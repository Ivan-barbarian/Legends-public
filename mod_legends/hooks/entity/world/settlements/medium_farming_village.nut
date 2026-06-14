::mods_hookExactClass("entity/world/settlements/medium_farming_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Apprentice,
			::Legends.Background.Beggar,
			::Legends.Background.Butcher,
			::Legends.Background.Gambler,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Farmhand,
			::Legends.Background.Farmhand,
			::Legends.Background.Farmhand,
			::Legends.Background.Juggler,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Miller,
			::Legends.Background.Miller,
			::Legends.Background.Minstrel,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			::Legends.Background.Servant,
			::Legends.Background.Tailor,
			::Legends.Background.Vagabond,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Apprentice,
			"female_beggar_background",
			::Legends.Background.Butcher,
			::Legends.Background.Gambler,
			"female_daytaler_background",
			"female_daytaler_background",
			"female_farmhand_background",
			"female_farmhand_background",
			"female_farmhand_background",
			::Legends.Background.Juggler,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			"female_miller_background",
			"female_miller_background",
			::Legends.Background.Minstrel,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Refugee,
			"female_servant_background",
			"female_tailor_background",
			::Legends.Background.Vagabond,
			::Legends.Background.RetiredSoldier
		];
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		];
	}

	o.onBuild = function ( )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = this.Math.rand(1, 3);

		if (r == 1 || this.Const.World.Buildings.Blackmarket == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wool_spinner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			this.Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
			this.Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Plains
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 3, true);
	}
});