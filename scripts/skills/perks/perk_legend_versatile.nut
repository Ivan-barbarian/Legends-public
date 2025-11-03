this.perk_legend_versatile <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeBonus = false,
		RangedBonus = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendVersatile);
	}

	function onCombatFinished()
	{
		this.m.MeleeBonus = false;
		this.m.RangedBonus = false;
	}

	function onUpdate(_properties)
	{
		if (this.m.MeleeBonus)
			_properties.MeleeDamageMult *= 1.5;

		if (this.m.RangedBonus)
			_properties.RangedDamageMult *= 1.5;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill == null)
			return;

		if (!_skill.isAttack())
			return;

		if (_skill.isRanged()) {
			this.m.MeleeBonus = true;
			this.m.RangedBonus = false;
		} else {
			this.m.MeleeBonus = false;
			this.m.RangedBonus = true;
		}
	}
});
