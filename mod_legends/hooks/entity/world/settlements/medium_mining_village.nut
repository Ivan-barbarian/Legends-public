::mods_hookExactClass("entity/world/settlements/medium_mining_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Apprentice,
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			::Legends.Background.Daytaler,
			::Legends.Background.Juggler,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Servant,
			::Legends.Background.Shepherd,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Apprentice,
			::Legends.Background.Apprentice,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			"female_daytaler_background",
			::Legends.Background.Juggler,
			::Legends.Background.KillerOnTheRun,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Ratcatcher,
			"female_servant_background",
			::Legends.Background.Shepherd,
			"female_thief_background",
			::Legends.Background.Vagabond
		];
		this.m.StablesList = [
			::Legends.Background.LegendDonkey
		];
	}
});