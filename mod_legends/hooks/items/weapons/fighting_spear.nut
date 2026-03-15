::mods_hookExactClass("items/weapons/fighting_spear", function(o) {
	
	o.isAmountShown <- function()
	{
		return true;
	}

	o.setAmmo <- function ( _a )
	{
		this.weapon.setAmmo(_a);
	}

	o.getAmountString <- function ()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2100;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 10;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Ammo;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/spear_03" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/spear_03" + v + ".png";
		this.m.ArmamentIcon = "icon_spear_03" + v;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Thrust);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Spearwall);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.ThrowJavelin, function (_skill) {
			_skill.m.IsBackupSpear = true;
		}.bindenv(this));
	}

});
