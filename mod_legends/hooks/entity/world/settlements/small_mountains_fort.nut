::mods_hookExactClass("entity/world/settlements/small_mountains_fort", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Beggar,
			::Legends.Background.Beggar,
			::Legends.Background.Brawler,
			::Legends.Background.Daytaler,
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Vagabond,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.Apprentice,
			::Legends.Background.Houndmaster,
			::Legends.Background.Brawler,
			"female_daytaler_background",
			::Legends.Background.Mason,
			::Legends.Background.Messenger,
			::Legends.Background.Militia,
			::Legends.Background.Militia,
			::Legends.Background.Vagabond,
			::Legends.Background.Witchhunter,
			::Legends.Background.Bastard,
			::Legends.Background.Deserter,
			::Legends.Background.Deserter,
			::Legends.Background.RetiredSoldier,
			::Legends.Background.RetiredSoldier
		];
		this.m.StablesList = [
			::Legends.Background.LegendDonkey,
			::Legends.Background.LegendHorseRouncey
		];
	}
});