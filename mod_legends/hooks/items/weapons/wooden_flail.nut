::mods_hookExactClass("items/weapons/wooden_flail", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist | this.Const.Items.ItemType.Pitchfork;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/flail_02_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/flail_02_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_flail_02_" + this.m.Variant;
	}

});
