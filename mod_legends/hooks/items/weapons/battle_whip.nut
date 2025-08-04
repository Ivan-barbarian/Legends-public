::mods_hookExactClass("items/weapons/battle_whip", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Cleaver, Whip, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/whip_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/whip_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_whip_01_" + this.m.Variant;
	}

});
