::mods_hookExactClass("items/weapons/named/named_spear", function(o) {

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
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3, 4, 5, 6];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 10;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Ammo;
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Thrust);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Spearwall);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.ThrowJavelin, function (_skill) {
			_skill.m.IsBackupSpear = true;
		}.bindenv(this));
	}
});
