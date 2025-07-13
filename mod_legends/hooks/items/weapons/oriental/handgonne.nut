::mods_hookExactClass("items/weapons/oriental/handgonne", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/ranged/handgonne_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/handgonne_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_handgonne_01_" + this.m.Variant + "_loaded";
	}

	local setLoaded = o.setLoaded;
	o.setLoaded = function (_l) {
		setLoaded(_l);
		if (this.m.Variant == 0) {
			return;
		}
		if (_l) {
			this.m.ArmamentIcon = "icon_handgonne_01_" + this.m.Variant + "_loaded";
		} else {
			this.m.ArmamentIcon = "icon_handgonne_01_" + this.m.Variant + "_empty";
		}
		this.updateAppearance();
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.m.IsLoaded = true;
	}
});
