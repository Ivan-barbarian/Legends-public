::mods_hookExactClass("items/weapons/military_cleaver", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2500;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/cleaver_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/cleaver_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_cleaver_01_" + this.m.Variant;
	}

});
