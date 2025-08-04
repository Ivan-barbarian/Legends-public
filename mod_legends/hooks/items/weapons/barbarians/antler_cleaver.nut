::mods_hookExactClass("items/weapons/barbarians/antler_cleaver", function(o) {

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
		this.m.Icon = "weapons/melee/wildmen_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_wildmen_01_" + this.m.Variant;
	}

});
