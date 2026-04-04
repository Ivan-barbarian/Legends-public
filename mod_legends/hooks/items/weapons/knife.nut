::mods_hookExactClass("items/weapons/knife", function(o) {	
	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));

		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
		this.m.AmmoCost = 1;
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/knife_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/knife_01" + v + ".png";
		this.m.ArmamentIcon = "icon_knife_01" + v;
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Deathblow);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendThrowKnife);
	}

});
