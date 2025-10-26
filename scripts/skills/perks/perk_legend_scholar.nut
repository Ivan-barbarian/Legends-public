this.perk_legend_scholar <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendScholar);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded() {
		::World.Assets.m.HasScholars++;
	}

	function onRemoved() {
		::World.Assets.m.HasScholars--;
	}

	function onDeath(_fatalityType) {
		::World.Assets.m.HasScholars--;
	}

});
