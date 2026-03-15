::mods_hookExactClass("items/weapons/ancient/ancient_spear", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 10;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Ammo;
	}

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
