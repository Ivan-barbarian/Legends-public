::mods_hookDescendants("skills/skill", function (o) {
	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function (_properties) {
		onAfterUpdate(_properties);
		if (this.m.IsWeaponSkill) {
			this.m.FatigueCostMult = ::Legends.S.isCharacterWeaponSpecialized(_properties, this.getItem()) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}
	}
});