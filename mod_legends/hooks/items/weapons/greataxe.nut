::mods_hookExactClass("items/weapons/greataxe", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2725;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/axe_two_handed_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/axe_two_handed_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_axe_two_handed_01_" + this.m.Variant;
	}

});
