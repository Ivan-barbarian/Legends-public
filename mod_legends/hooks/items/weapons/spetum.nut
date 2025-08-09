::mods_hookExactClass("items/weapons/spetum", function(o) {
	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendSkewer);
	}
});
