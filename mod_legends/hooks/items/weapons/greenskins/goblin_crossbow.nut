::mods_hookExactClass("items/weapons/greenskins/goblin_crossbow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A large and heavy crossbow with menacing spikes in front. More like a minitature ballista, it shoots stakes with enough force to knock back a target hit. Deals +100 damage to vampires.";
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
	}

	o.updateVariant <- function()
	{
		this.m.Icon = "weapons/ranged/crossbow_goblin_0" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/crossbow_goblin_0" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_crossbow_goblin_0" + this.m.Variant;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingBolt);
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
	}
});
