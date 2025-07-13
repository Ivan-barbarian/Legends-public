::mods_hookExactClass("items/weapons/two_handed_flanged_mace", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 3000;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/mace_two_handed_02_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/mace_two_handed_02_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_mace_two_handed_02_" + this.m.Variant;
	}

});
