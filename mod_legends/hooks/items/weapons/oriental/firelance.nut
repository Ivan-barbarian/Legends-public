::mods_hookExactClass("items/weapons/oriental/firelance", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/ranged/firelance_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/firelance_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_firelance_01_" + this.m.Variant;
	}

	local setAmmo = o.setAmmo;
	o.setAmmo = function(_a) {
		setAmmo(_a);
		if (this.m.Variant == 0) {
			return;
		}
		if (this.m.Ammo > 0) {
			this.m.Icon = "weapons/ranged/firelance_01_" + this.m.Variant + "_70x70.png";
			this.m.IconLarge = "weapons/ranged/firelance_01_" + this.m.Variant + ".png";
			this.m.ArmamentIcon = "icon_firelance_01_" + this.m.Variant;
		} else {
			this.m.Icon = "weapons/ranged/firelance_02_" + this.m.Variant + "_70x70.png";
			this.m.IconLarge = "weapons/ranged/firelance_02_" + this.m.Variant + ".png";
			this.m.ArmamentIcon = "icon_firelance_01_" + this.m.Variant + "_empty";
		}
		this.updateAppearance();
	}

});
