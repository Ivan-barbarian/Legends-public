::mods_hookExactClass("items/weapons/greenskins/orc_flail_2h", function(o) {

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
		this.m.Icon = "weapons/melee/orc_flail_two_handed_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/orc_flail_two_handed_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_orc_weapon_05_" + this.m.Variant;
	}

});
