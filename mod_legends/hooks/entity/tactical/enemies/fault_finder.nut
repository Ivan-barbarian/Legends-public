::mods_hookExactClass("entity/tactical/enemies/fault_finder", function(o) {
	o.assignRandomEquipment = function ()
	{
		local weapons =	[
			"scripts/items/weapons/knife",
			"scripts/items/weapons/dagger",
			"scripts/items/weapons/butchers_cleaver"
		];
		this.m.Items.equip(this.new(weapons[::Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.fault_finder_robes]
		]));

		this.m.Items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.fault_finder_mask_01],
			[1, ::Legends.Helmet.Standard.fault_finder_mask_02]
		]));
	}
});
