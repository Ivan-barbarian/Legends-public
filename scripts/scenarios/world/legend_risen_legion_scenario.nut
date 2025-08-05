this.legends_risen_legion_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legend_risen_legion";
		this.m.Name = "Risen Legion";
		this.m.Description = "[p=c][img]gfx/ui/events/event_73.png[/img][/p]An ancient legion risen from the dead with orders to reclaim the world.\n\n[color=#bcad8c]Dreaded:[/color] All towns will begin and stay hostile to you.\n[color=#bcad8c]Fighting legion:[/color] Higher and average marching speed across difficult terrain, begin with 8 fighters and field up to 25.\n[color=#bcad8c]Dead walking:[/color] You cannot hire in towns, but you may find recruits by patrolling near Mass graves, Sunken Castles and The Monolith. Ancient dead are allied to you.\n";
		this.m.Difficulty = 4;
		this.m.Order = 140;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(27);
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(27);
	}

	o.onSpawnAssets = function ()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 8; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			// ::Legends.Traits.grant(bro, ::Legends.Trait.LegendFleshless);
			bro.setVeteranPerks(3);
			///---
			bro.getSprite("socket").setBrush("bust_base_undead");
			///---
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll(); //this will please the romeaboos
		//8 to start - 4 slaves, 2 aux, 2 legionaries

		bros[0].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[0].setPlaceInFormation(3);
		local items = bros[0].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[1].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[1].setPlaceInFormation(4);
		local items = bros[1].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[2].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[2].setPlaceInFormation(5);
		local items = bros[2].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[3].setStartValuesEx([
			"legend_legion_slave_background"
		]);
		bros[3].setPlaceInFormation(10);
		local items = bros[3].getItems();
		items.addToBag(this.new("scripts/items/weapons/javelin"));

		bros[4].setStartValuesEx([
			"legend_legion_auxiliary_background"
		]);
		bros[4].setPlaceInFormation(11);
		local items = bros[4].getItems();
		items.addToBag(this.new("scripts/items/tools/throwing_net"));

		bros[5].setStartValuesEx([
			"legend_legion_auxiliary_background"
		]);
		bros[5].setPlaceInFormation(12);
		local items = bros[5].getItems();
		items.addToBag(this.new("scripts/items/tools/throwing_net"));

		bros[6].setStartValuesEx([
			"legend_legion_legionary_background"
		]);
		bros[6].setPlaceInFormation(17);
		local items = bros[6].getItems();
		items.addToBag(this.new("scripts/items/weapons/throwing_spear"));

		bros[7].setStartValuesEx([
			"legend_legion_legionary_background"
		]);
		bros[7].setPlaceInFormation(18);
		local items = bros[7].getItems();
		items.addToBag(this.new("scripts/items/weapons/throwing_spear"));


		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().add(this.new("scripts/items/loot/ancient_gold_coins_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/tents/legend_tent_train"));
		this.World.Assets.getStash().add(this.new("scripts/items/tents/legend_tent_repair"));
		this.World.Assets.getStash().add(this.new("scripts/items/tents/legend_tent_scout"));
		this.World.Assets.getStash().add(this.new("scripts/items/tents/legend_tent_heal"));
		this.World.Assets.getStash().add(this.new("scripts/items/tents/legend_tent_scrap"));
		this.World.Assets.getStash().add(this.new("scripts/items/tents/legend_tent_fletcher"));
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 9);

	}

	function onSpawnPlayer()
	{
		local spawnTile;
		local settlements = this.World.EntityManager.getSettlements();
		local nearestVillage;
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(5, this.Const.World.Settings.SizeX - 5);
			local y = this.Math.rand(5, this.Const.World.Settings.SizeY - 5);

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}		
				else if (tile.Type != this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					local next = true;

					foreach( s in settlements )
					{
						local d = s.getTile().getDistanceTo(tile);

						if (d > 6 && d < 15)
						{
							local path = this.World.getNavigator().findPath(tile, s.getTile(), navSettings, 0);

							if (!path.isEmpty())
							{
								next = false;
								nearestVillage = s;
								break;
							}
						}
					}

					if (next)
					{
					}
					else
					{
						spawnTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local attachedLocations = randomVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(randomVillageTile) < dist)
			{
				dist = a.getTile().getDistanceTo(randomVillageTile);
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke(); 
		}

		local settlement = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement); //pes. factions

		foreach( n in settlement )
		{
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( n in oriental )
		{
			n.addPlayerRelation(-400.0, "You are the undead, to be despised");
		}

		local skellies = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Undead);

		foreach( n in skellies )
		{
			n.addPlayerRelation(400.0, "For the empire!");
		}

		this.m.StaticRelationsToFaction[this.Const.FactionType.Settlement] = true;
		this.m.StaticRelationsToFaction[this.Const.FactionType.NobleHouse] = true;
		this.m.StaticRelationsToFaction[this.Const.FactionType.OrientalCityState] = true;
		this.m.StaticRelationsToFaction[this.Const.FactionType.Undead] = true;
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(112);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/undead_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_risen_legion_intro");
		}, null);
		this.World.Flags.set("HasLegendCampGathering", true);
		this.World.Flags.set("HasLegendCampCrafting", true);
		this.World.Flags.set("HasLegendCampFletching", true);
		this.World.Flags.set("HasLegendCampHealing", true);
		this.World.Flags.set("HasLegendCampHunting", true);
		this.World.Flags.set("HasLegendCampScouting", true);
		this.World.Flags.set("HasLegendCampScraping", true);
		this.World.Flags.set("HasLegendCampTraining", true);
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.isStabled())
			{
				continue;
			}

			if (!bro.isStabled())
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	function onHiredByScenario( bro )
	{
		if (!bro.getSkills().hasTrait(::Legends.Trait.RacialSkeleton) && bro.getFlags().has("skeleton"))
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.RacialSkeleton);
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendFleshless);
		}
	}

	function onInit()
	{
		this.starting_scenario.onInit();
	}

});

