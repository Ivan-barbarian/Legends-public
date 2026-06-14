::mods_hookExactClass("entity/world/settlements/small_snow_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Beggar,
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Lumberjack,
			::Legends.Background.Mason,
			::Legends.Background.Miner,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			"female_beggar_background",
			::Legends.Background.Brawler,
			::Legends.Background.Brawler,
			::Legends.Background.Cultist,
			"female_daytaler_background",
			::Legends.Background.Lumberjack,
			::Legends.Background.Mason,
			::Legends.Background.Miner,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			"female_thief_background",
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman
		];
	}
});