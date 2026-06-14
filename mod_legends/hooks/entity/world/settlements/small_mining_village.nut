::mods_hookExactClass("entity/world/settlements/small_mining_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Apprentice,
			::Legends.Background.Beggar,
			::Legends.Background.Brawler,
			::Legends.Background.Daytaler,
			::Legends.Background.Graverobber,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Thief,
			::Legends.Background.Poacher,
			::Legends.Background.Apprentice,
			"female_beggar_background",
			::Legends.Background.Brawler,
			"female_daytaler_background",
			::Legends.Background.Graverobber,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			"female_thief_background",
			::Legends.Background.Poacher
		];
	}
});