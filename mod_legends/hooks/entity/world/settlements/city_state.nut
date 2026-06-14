::mods_hookExactClass("entity/world/settlements/city_state", function(o)
{

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.FemaleDraftList = [
			::Legends.Background.LegendQiyan
		];
		this.m.DraftList = [
			"beggar_southern_background",
			"beggar_southern_background",
			"butcher_southern_background",
			::Legends.Background.CaravanHandSouthern,
			::Legends.Background.CaravanHandSouthern,
			::Legends.Background.CaravanHandSouthern,
			"gambler_southern_background",
			::Legends.Background.DaytalerSouthern,
			::Legends.Background.DaytalerSouthern,
			"historian_southern_background",
			"peddler_southern_background",
			"peddler_southern_background",
			"servant_southern_background",
			::Legends.Background.ShepherdSouthern,
			::Legends.Background.ShepherdSouthern,
			"tailor_southern_background",
			"thief_southern_background",
			::Legends.Background.DisownedNoble,
			::Legends.Background.Sellsword,
			"cripple_southern_background",
			"eunuch_southern_background",
			::Legends.Background.Slave,
			::Legends.Background.Slave,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.SlaveSouthern,
			::Legends.Background.Manhunter,
			::Legends.Background.Manhunter,
			::Legends.Background.Nomad,
			::Legends.Background.Nomad,
			::Legends.Background.NomadRanged,
			::Legends.Background.JugglerSouthern,
			::Legends.Background.AssassinSouthern,
			::Legends.Background.LegendMuladi,
			::Legends.Background.LegendDervish,
			::Legends.Background.BeastSlayer
		];
	}

	o.getSpriteName <- function ()
	{
		return this.m.Sprite;
	}

	o.buildNewLocation <- function ()
	{
		local ALL = [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.SnowyForest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Desert,
			this.Const.World.TerrainType.Oasis
		];
		local items = [
			[1, {
				Script = "scripts/entity/world/attached_location/harbor_location",
				Terrain = [this.Const.World.TerrainType.Shore],
				NearTerrain = [this.Const.World.TerrainType.Shore, this.Const.World.TerrainType.Ocean],
				Distance = 1,
				Road = false,
				Clear = false,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/fishing_huts_oriental_location",
				Terrain = ALL,
				NearTerrain = [this.Const.World.TerrainType.Shore],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/incense_dryer_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/silk_farm_location",
				Terrain = ALL
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/plantation_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/dye_maker_oriental_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],

			[1, {
				Script = "scripts/entity/world/attached_location/goat_herd_oriental_location",
				Terrain = ALL,
				NearTerrain = [],
				Distance = 1,
				Road = false,
				Clear = true,
				Force = true
			}],


		];

		items = this.filterNewLocation(items);
		local item = this.Const.World.Common.pickItem(items);
		return this.buildAttachedLocation(1, item.Script, item.Terrain, item.NearTerrain, item.Distance, item.Road, item.Clear, item.Force)
	}

	o.onSerialize <- function ( _out )
	{
		this.settlement.onSerialize(_out);
		_out.writeU8(this.m.AttachedLocationsMax);
	}

	o.onDeserialize <- function ( _in )
	{
		this.settlement.onDeserialize(_in);
		this.m.AttachedLocationsMax = _in.readU8();
	}
});
