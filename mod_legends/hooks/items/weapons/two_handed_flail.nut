::mods_hookExactClass("items/weapons/two_handed_flail", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.Value = 2800;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/flail_two_handed_02_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/flail_two_handed_02_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_flail_two_handed_02_" + this.m.Variant;
	}

});
