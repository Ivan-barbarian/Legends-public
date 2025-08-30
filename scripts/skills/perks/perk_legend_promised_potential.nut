this.perk_legend_promised_potential <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendPromisedPotential);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		local actor = this.getContainer().getActor();
		if (actor.m.Type != this.Const.EntityType.Player)
			return;
		local talents = actor.getTalents();
		if (talents.len() == 0)
			return;

		_properties.Hitpoints += this.Math.min(1, talents[::Const.Attributes.Hitpoints] * 2);
		_properties.Bravery += this.Math.min(1, talents[::Const.Attributes.Bravery] * 2);
		_properties.Fatigue += this.Math.min(1, talents[::Const.Attributes.Fatigue] * 2);
		_properties.Initiative += this.Math.min(1, talents[::Const.Attributes.Initiative] * 2);
		_properties.MeleeSkill += this.Math.min(1, talents[::Const.Attributes.MeleeSkill] * 2);
		_properties.RangedSkill += this.Math.min(1, talents[::Const.Attributes.RangedSkill] * 2);
		_properties.MeleeDefense += this.Math.min(1, talents[::Const.Attributes.MeleeDefense] * 2);
		_properties.RangedDefense += this.Math.min(1, talents[::Const.Attributes.RangedDefense] * 2);
	}
});
