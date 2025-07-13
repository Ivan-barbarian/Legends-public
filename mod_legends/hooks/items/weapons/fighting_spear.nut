::mods_hookExactClass("items/weapons/fighting_spear", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2100;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/spear_03_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/spear_03_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_spear_03_" + this.m.Variant;
	}

});
