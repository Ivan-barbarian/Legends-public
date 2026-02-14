::mods_hookExactClass("skills/perks/perk_mastery_throwing", function(o) {
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isRanged())
			return;

		local weapon = _skill.getItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			return;

		_properties.DamageArmorMult += 0.25;
		_properties.DamageDirectAdd += 0.2;
		_properties.ThresholdToInflictInjuryMult *= 0.67;
	}
});
