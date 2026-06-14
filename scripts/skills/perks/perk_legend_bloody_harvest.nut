this.perk_legend_bloody_harvest <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBloodyHarvest);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack())
		{
			local bonus = this.Math.round(_skill.getFatigueCost() * 0.5);
			_properties.DamageTotalMult += 0.01 * bonus;
		}
	}

});

