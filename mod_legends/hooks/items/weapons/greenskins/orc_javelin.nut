::mods_hookExactClass("items/weapons/greenskins/orc_javelin", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Throwing Weapon, Spear, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.35;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/ranged/orc_javelins_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/orc_javelins_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_orc_javelin_01_" + this.m.Variant;
	}

	local setAmmo = o.setAmmo;
	o.setAmmo = function(_a) {
		setAmmo(_a);
		if (this.m.Variant == 0) {
			return;
		}
		if (this.m.Ammo > 0) {
			this.m.Icon = "weapons/ranged/orc_javelins_01_" + this.m.Variant + "_70x70.png";
			this.m.IconLarge = "weapons/ranged/orc_javelins_01_" + this.m.Variant + ".png";
		} else {
			this.m.Icon = "weapons/ranged/orc_javelins_bag_70x70.png";
			this.m.IconLarge = "weapons/ranged/orc_javelins_bag_140x70.png";
		}
		this.updateAppearance();
	}

});
