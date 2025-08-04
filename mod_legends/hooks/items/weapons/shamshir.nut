::mods_hookExactClass("items/weapons/shamshir", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Cleaver/Sword, One-Handed";
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/scimitar_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/scimitar_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_scimitar_01_" + this.m.Variant;
	}

});
