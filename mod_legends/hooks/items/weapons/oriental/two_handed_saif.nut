::mods_hookExactClass("items/weapons/oriental/two_handed_saif", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2400;
		this.m.Categories = "Sword, Cleaver, Two-Handed";
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/two_handed_saif_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/two_handed_saif_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_two_handed_saif_01_" + this.m.Variant;
	}

});
