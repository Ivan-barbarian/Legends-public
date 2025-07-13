::mods_hookExactClass("items/weapons/goedendag", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Spear, Mace, Two-Handed";
		this.m.Value = 750;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/goedendag_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/goedendag_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_goedendag_01_" + this.m.Variant;
	}

});
