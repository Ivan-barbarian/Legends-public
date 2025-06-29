this.legend_camp_smuggle_contract <- ::inherit("scripts/contracts/legend_camp_contract", {
	m = {
		Town = null,
		Fortress = null,
		Camp = null
	},
	function create() {
		this.contract.create();
		this.m.Type = "contract.legend_camp_smuggle_contract";
		this.m.Name = "Smuggle item";
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Bandits;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = ::Math.rand(95, 135) * 0.01;
		this.m.DescriptionTemplates = [
			"Bandits want to procure an item, but as outlaws they cannot enter town.",
			"Local criminal is in dire need of new equipment. You can help them smuggle goods.",
		];
	}

	function isVisible() {
		// exclude desert i guess?
		local currentTile = ::World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y < ::World.getMapSize().Y * 0.3)
			return false;

		local sourceSettlements = [];
		local militarySettlements = [];
		foreach (settlement in ::World.EntityManager.getSettlements()) {
			if (!::MSU.isKindOf(settlement, "settlement"))
				continue;
			if (settlement.isIsolatedFromRoads())
				continue;
			if (settlement.isMilitary()) {
				militarySettlements.push(settlement);
			} else {
				sourceSettlements.push(settlement)
			}
		}

		if (sourceSettlements.len() == 0)
			return false;

		if (militarySettlements.len() == 0)
			return false;
		return true;
	}

	function start() {
		this.m.Payment.Pool = 600 * this.getPaymentMult() * ::Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		this.m.Payment.Completion = 1.0;

		local sourceSettlements = [];
		local militarySettlements = [];
		foreach (settlement in ::World.EntityManager.getSettlements()) {
			if (!::MSU.isKindOf(settlement, "settlement"))
				continue;
			if (settlement.isIsolatedFromRoads())
				continue;
			if (settlement.isMilitary()) {
				militarySettlements.push(settlement);
			} else {
				sourceSettlements.push(settlement)
			}
		}
		// limit these to 3 nearest
		sourceSettlements.sort(this.onSortByDistance);
		while(sourceSettlements.len() > 3)
			sourceSettlements.pop();

		this.m.Town = ::WeakTableRef(sourceSettlements[::Math.rand(0, sourceSettlements.len() - 1)]);
		this.m.Fortress = ::WeakTableRef(militarySettlements[::Math.rand(0, militarySettlements.len() - 1)]);

		this.contract.start();
	}

	function createStates() {
		this.m.States.push({
			ID = "Offer",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Pick up requested item from " + this.Contract.Town.getName()
				];

				if (::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance) {
					this.Contract.setScreen("Intro");
				} else {
					this.Contract.setScreen("Task");
				}
			}

			function end() {
				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Flags.set("Nobles", ::Math.rand(0, 2) == 0); // 33% spawned party will be noble patrol
				if (::Math.rand(0, 2)) { // 66% chance for enemy spawn
					if(::Math.rand(0, 1)) {
						this.Flags.set("Ambush", true); // 50% for ambush
					} else {
						this.Flags.set("Pursuit", true); // 50% for pursuit
					}
				}

				::World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				this.Contract.setScreen("Overview");
				::World.Contracts.setActiveContract(this.Contract);
				this.Contract.m.Town.getSprite("selection").Visible = true;
			}
		});

		this.m.States.push({
			ID = "Running",
			function start() {
				this.Contract.m.Town.getSprite("selection").Visible = true;
			}
			function update() {
				if (this.Contract.isPlayerAt(this.Contract.m.Town)) {
					this.Contract.setScreen("ItemPickedUp");
					::World.Contracts.showActiveContract();
				}
			}
		});

		this.m.States.push({
			ID = "Delivery",
			function start() {
				if (this.Contract.m.Camp != null && !this.Contract.m.Camp.isNull())
					this.Contract.m.Camp.getSprite("selection").Visible = true;
				this.Contract.m.BulletpointsObjectives = [
					"Deliver requested item to bandit camp"
				];
			}
			function update() {
				if (this.Contract.isPlayerAt(this.Contract.m.Camp)) {
					this.Contract.setScreen("Success");
					::World.Contracts.showActiveContract();
				}
			}
		});
	}

	function createScreens() {
		this.importScreens(::Const.Contracts.NegotiationDefault);
		this.importScreens(::Const.Contracts.Overview);

		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{TODO}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [{
				Text = "{The %companyname% can help for the right price. | Let\'s talk crowns.}",
				function getResult() {
					return "Negotiation";
				}
			}, {
				Text = "{This doesn\'t sound like our kind of work. | This won\'t be worth the risk.}",
				function getResult() {
					this.World.Contracts.removeContract(this.Contract);
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "ItemPickedUp",
			Title = "Inside town",
			Text = "[img]gfx/ui/events/event_112.png[/img]{TODO}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [{
				Text = "{Pick item and head out.}",
				function getResult() {
					this.Contract.m.Town.getSprite("selection").Visible = false;
					this.Contract.m.Camp = ::WeakTableRef(::World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getNearestSettlement(::World.State.getPlayer().getTile()));
					this.Contract.m.Camp.getFlags().set("isContractLocation", true);
					this.Contract.m.Camp.setDiscovered(true);
					::World.uncoverFogOfWar(this.Contract.m.Camp.getPos(), 250.0);
					::Settings.getTempGameplaySettings().CameraLocked = false;
					::World.getCamera().Zoom = 1.0;
					::World.getCamera().setPos(this.Contract.m.Camp.getPos());
					if (this.Flags.has("Pursuit")) {
						this.spawnPursuitParty();
					}
	//				::World.Assets.getStash().add(::new("scripts/items/tools/legend_unhold_throwing_net"));
					this.Contract.setState("Delivery");
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "Success",
			Title = "At bandit camp...",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You hand over the package over to the %employer%.%speech_on%Give me that and now scram.%speech_off%You leave the camp, wondering if you really did right thing.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "{Perhaps, such is life.}",
				function getResult() {
					::World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
					::World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
					::World.Contracts.finishActiveContract();
					return 0;
				}
			}],
			function start() {
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}
		});
	}

	function onSortByDistance( _a, _b ) {
		local distance1 = _a.getTile().getDistanceTo(::World.State.getPlayer().getTile());
		local distance2 = _b.getTile().getDistanceTo(::World.State.getPlayer().getTile());
		if (distance1 > distance2)
			return 1;
		if (distance1 < distance2)
			return -1;
		return 0;
	}

	function spawnPursuitParty() {

	}

	function onPrepareVariables(_vars) {

	}

	function onClear() {
		if (!this.m.IsActive)
			return;

		if (this.m.Town != null && !this.m.Town.isNull()) {
			this.m.Town.getSprite("selection").Visible = false;
		}
		if (this.m.Camp != null && !this.m.Camp.isNull()) {
			this.m.Camp.getSprite("selection").Visible = false;
			this.m.Camp.getFlags().remove("isContractLocation");
		}
	}

	function onSerialize(_out) {
		if (this.m.Town != null && !this.m.Town.isNull()) {
			_out.writeU32(this.m.Town.getID());
		} else {
			_out.writeU32(0);
		}
		if (this.m.Fortress != null && !this.m.Fortress.isNull()) {
			_out.writeU32(this.m.Fortress.getID());
		} else {
			_out.writeU32(0);
		}
		if (this.m.Camp != null && !this.m.Camp.isNull()) {
			_out.writeU32(this.m.Camp.getID());
		} else {
			_out.writeU32(0);
		}
		this.contract.onSerialize(_out);
	}

	function onDeserialize(_in) {
		local target = _in.readU32();
		if (target != 0) {
			this.m.Town = this.WeakTableRef(this.World.getEntityByID(target));
		}
		target = _in.readU32();
		if (target != 0) {
			this.m.Fortress = this.WeakTableRef(this.World.getEntityByID(target));
		}
		target = _in.readU32();
		if (target != 0) {
			this.m.Camp = this.WeakTableRef(this.World.getEntityByID(target));
		}
		this.contract.onDeserialize(_in);
	}
});
