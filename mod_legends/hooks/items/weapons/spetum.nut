::mods_hookExactClass("items/weapons/spetum", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/spetum_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/spetum_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_spetum_01_" + this.m.Variant;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendSkewer);
	}

});
