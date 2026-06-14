::mods_hookExactClass("entity/world/settlements/small_tundra_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Brawler,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Farmhand,
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Shepherd,
			::Legends.Background.Tailor,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Brawler,
			"female_daytaler_background",
			"female_daytaler_background",
			"female_farmhand_background",
			::Legends.Background.Miner,
			::Legends.Background.Peddler,
			::Legends.Background.Poacher,
			::Legends.Background.Shepherd,
			"female_tailor_background",
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman
		];
	}
});