::mods_hookExactClass("items/weapons/pitchfork", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Pitchfork;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/pitchfork_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/pitchfork_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_pitchfork_01_" + this.m.Variant;
	}

});
