this.perk_legend_unarmed_training <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendUnarmedTraining);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.First + 2;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.FatigueDealtPerHitMult += 1.0;
		if (_targetEntity.isNull())
			return;
		if (!_targetEntity.isAlive())
			return;
		if (_targetEntity.isDying())
			return;

		local fatDamage = this.Const.Combat.FatigueReceivedPerHit * _properties.FatigueDealtPerHitMult + _targetEntity.getFatigueMax() * _properties.FatigueDealtAsPercentOfMaxFatigue;
		local p = _targetEntity.getCurrentProperties();
		fatDamage *= p.FatigueEffectMult;
		local overflow = this.Math.round(_targetEntity.getFatigue() + fatDamage * p.FatigueReceivedPerHitMult * _targetEntity.FatigueLossOnAnyAttackMult) - _targetEntity.getFatigueMax();
		if (overflow > 0)
		{
			_properties.DamageRegularMin += overflow;
			_properties.DamageRegularMax += overflow;
		}
	}
});
