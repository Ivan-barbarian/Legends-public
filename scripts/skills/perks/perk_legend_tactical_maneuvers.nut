this.perk_legend_tactical_maneuvers <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendTacticalManeuvers);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Rotation))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Rotation);
		}
		if (!this.m.Container.hasActive(::Legends.Active.Footwork))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Footwork);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Rotation);
		::Legends.Actives.remove(this, ::Legends.Active.Footwork);
	}

});
