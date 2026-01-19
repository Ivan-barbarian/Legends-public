::mods_hookExactClass("events/events/cultist_vs_uneducated_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- function (_event) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					this.Characters.push(_event.m.Cultist.getImagePath());
					this.Characters.push(_event.m.Uneducated.getImagePath());

					this.Characters.push(_event.m.Cultist.getImagePath());
					this.Characters.push(_event.m.Uneducated.getImagePath());
					local background = this.new("scripts/skills/backgrounds/converted_cultist_background");
					background.m.IsNew = false;
					local oldPerkTree = _event.m.Uneducated.getBackground().m.CustomPerkTree;
					_event.m.Uneducated.getSkills().removeByID(_event.m.Uneducated.getBackground().getID());
					_event.m.Uneducated.getSkills().add(background);
					_event.m.Uneducated.getBackground().m.RawDescription = "Who this figure was no longer matters. They now bear the mark of Davkul on their forehead and while their lips do not yet know the words of his newfound religion, they speak of the cult\'s fascination in a familiar tongue. Darkness, they say, is coming.";
					_event.m.Uneducated.getBackground().buildDescription(true);
					_event.m.Uneducated.getBackground().rebuildPerkTree(oldPerkTree);
					_event.m.Uneducated.resetPerks();
					_event.m.Uneducated.getSkills().update();
					background.buildDescription();
					background.onSetAppearance();
					//set relations
					this.List = [{
						id = 13,
						icon = _event.m.Uneducated.getBackground().getIcon(),
						text = _event.m.Uneducated.getName() + " has been converted to a Cultist"
					}];
					_event.m.Cultist.getBaseProperties().Bravery += 2;
					_event.m.Cultist.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Cultist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
					});
				}
			}
			if (s.ID == "C") {
				local start = s.start;
				s.start <- function (_event) {
					this.World.Assets.addMoralReputation(2);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
					start(_event);
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 4)
			return;

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers ) {
			switch (true)
			{
				case bro.getFlags().get("IsSpecial"):
				case bro.getFlags().get("IsPlayerCharacter"):
					continue;
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist):
					cultist_candidates.push(bro);
					continue;
				case bro.getBackground().getID() == "background.slave":
				case bro.getBackground().getID() == "background.legend_puppet":
				case bro.getBackground().getID() == "background.legend_commander_berserker":
				case bro.getBackground().getID() == "background.legend_berserker":
				case bro.getBackground().getID() == "background.legend_donkey":
					continue;
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist):
				{
					cultist_candidates.push(bro);
					continue;
				}
			 	case bro.getSkills().hasTrait(::Legends.Trait.Dumb):
				case bro.getSkills().hasSkill("injury.brain_damage"):
				{
					uneducated_candidates.push(bro);
					continue;
				}
				case bro.getSkills().hasTrait(::Legends.Trait.Bright):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated):
				case !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn):
					continue;
			}
			uneducated_candidates.push(bro);
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0)
			return;

		this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		this.m.Uneducated = uneducated_candidates[this.Math.rand(0, uneducated_candidates.len() - 1)];
		this.m.Score = cultist_candidates.len() * 5;
	}
})
