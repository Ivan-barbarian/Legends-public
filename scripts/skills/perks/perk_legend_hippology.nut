this.perk_legend_hippology <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendHippology);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		getContainer().getActor().getFlags().set("HasVeterinarian", true);
	}

	function onRemoved()
	{
		getContainer().getActor().getFlags().remove("HasVeterinarian");
	}

});

