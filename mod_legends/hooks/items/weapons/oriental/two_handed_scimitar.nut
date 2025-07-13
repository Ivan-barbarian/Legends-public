::mods_hookExactClass("items/weapons/oriental/two_handed_scimitar", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Sword, Cleaver, Two-Handed";
		this.m.Value = 2900;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/two_handed_scimitar_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/two_handed_scimitar_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "two_handed_scimitar_01_" + this.m.Variant;
	}

});
