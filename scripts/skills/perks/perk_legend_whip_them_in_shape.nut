this.perk_legend_whip_them_in_shape <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendWhipThemInShape);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		::World.Statistics.getFlags().set("HasDrillSergeant", true);
	}

	function onRemoved()
	{
		::World.Statistics.getFlags().remove("HasDrillSergeant");
	}
});
