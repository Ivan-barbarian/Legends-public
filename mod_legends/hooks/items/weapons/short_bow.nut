::mods_hookExactClass("items/weapons/short_bow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Shortbow;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/ranged/bow_02_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/bow_02_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_short_bow_" + this.m.Variant;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingShot);
		::Legends.Actives.grant(this, ::Legends.Active.LegendCascade);
	}

});
