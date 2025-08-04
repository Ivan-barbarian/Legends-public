::mods_hookExactClass("items/weapons/three_headed_flail", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2200;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/flail_three_headed_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/flail_three_headed_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_flail_three_headed_01_" + this.m.Variant;
	}

});
