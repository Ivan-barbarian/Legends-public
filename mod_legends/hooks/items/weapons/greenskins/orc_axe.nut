::mods_hookExactClass("items/weapons/greenskins/orc_axe", function(o) {

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
		this.setVariant(this.Math.rand(0, 2));
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 10;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/orc_axe" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/orc_axe" + v + ".png";
		this.m.ArmamentIcon = "icon_orc_weapon_02" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function()
	{
		onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.ThrowAxe, function (_skill) {
			_skill.m.IsBackupAxe = true;
		}.bindenv(this));
	}

});
