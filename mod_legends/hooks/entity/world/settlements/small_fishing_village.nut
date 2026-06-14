::mods_hookExactClass("entity/world/settlements/small_fishing_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Beggar,
			::Legends.Background.Beggar,
			::Legends.Background.Daytaler,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Gravedigger,
			::Legends.Background.Peddler,
			::Legends.Background.Tailor,
			::Legends.Background.Vagabond,
			::Legends.Background.Vagabond,
			"female_beggar_background",
			"female_beggar_background",
			"female_daytaler_background",
			"female_butcher_background",
			"female_butcher_background",
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Fisherman,
			::Legends.Background.Gravedigger,
			::Legends.Background.Peddler,
			"female_tailor_background",
			::Legends.Background.Vagabond,
			::Legends.Background.Vagabond
		];
	}
});