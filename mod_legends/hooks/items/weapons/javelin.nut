::mods_hookExactClass("items/weapons/javelin", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon, Spear, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/ranged/javelins_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/javelins_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_javelin_01_" + this.m.Variant;
	}

	local setAmmo = o.setAmmo;
	o.setAmmo = function(_a) {
		setAmmo(_a);
		if (this.m.Variant == 0) {
			return;
		}
		if (this.m.Ammo > 0) {
			this.updateVariant();
			this.updateAppearance();
		}
	}

});
