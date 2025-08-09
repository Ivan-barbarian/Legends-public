::mods_hookExactClass("entity/tactical/humans/militia", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistMilitia);

		::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.SpecSpear);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecSpearWall);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecSpearThrust);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null) {
			local weapons = [
				"weapons/legend_militia_glaive",
				"weapons/militia_spear",
				"weapons/ancient/ancient_spear",
				"weapons/legend_saw",
				"weapons/legend_sickle"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 2) == 1) {
			local shields = [
				"shields/buckler_shield",
				"shields/wooden_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
			[1, "sackcloth"],
			[1, "padded_surcoat"],
			[1, "thick_tunic"],
			[1, "apron"]
		]));

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "aketon_cap"],
				[1, "open_leather_cap"],
				[1, "full_leather_cap"],
				[1, "headscarf"]
			]))
		}
	}
});
