::mods_hookExactClass("items/weapons/military_pick", function(o) {

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
		this.m.Icon = "weapons/melee/military_pick_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/military_pick_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_pick_01_" + this.m.Variant;
	}

});
