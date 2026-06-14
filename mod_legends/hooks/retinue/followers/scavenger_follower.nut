::mods_hookExactClass("retinue/followers/scavenger_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.scavenger";
		this.m.Name = "Scavenger's Cart";
		this.m.Description = "While mundane, the act of taking everything not nailed down after a battle can save a lot of money later down the road. Comes with pliars to open deathgrips.";
		this.m.Image = "ui/campfire/legend_scavenger_01";
		this.m.Cost = 1500;
		this.m.Effects = [
			"Recovers a part of all ammo you use during battle",
			"Recovers tools and supplies from every armor destroyed by you during battle"
		];

		this.addSkillRequirement("Have at least one of the following backgrounds: Beggar, Cripple, Refugee, Indebted", [
			::Legends.Backgrounds.IDs.Beggar,
			::Legends.Backgrounds.IDs.Cripple,
			::Legends.Backgrounds.IDs.Refugee,
			::Legends.Backgrounds.IDs.Slave,
			::Legends.Backgrounds.IDs.LegendCommanderBeggar,
			::Legends.Backgrounds.IDs.LegendCommanderBeggarScaling,
			::Legends.Backgrounds.IDs.LegendCompanionMelee,
			::Legends.Backgrounds.IDs.LegendCompanionRanged
		]);
	}

	o.onUpdate = function ()
	{
		if ("IsRecoveringAmmo" in this.World.Assets.m)
			this.World.Assets.m.IsRecoveringAmmo = true;
		if ("IsRecoveringArmor" in this.World.Assets.m)
			this.World.Assets.m.IsRecoveringArmor = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

