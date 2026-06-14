::mods_hookExactClass("entity/world/settlements/small_steppe_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Apprentice,
			::Legends.Background.Beggar,
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Peddler,
			::Legends.Background.Refugee,
			::Legends.Background.Tailor,
			::Legends.Background.Thief,
			::Legends.Background.Vagabond,
			::Legends.Background.Poacher,
			::Legends.Background.Apprentice,
			"female_beggar_background",
			::Legends.Background.Brawler,
			::Legends.Background.CaravanHand,
			::Legends.Background.Gambler,
			"female_daytaler_background",
			"female_daytaler_background",
			::Legends.Background.Peddler,
			::Legends.Background.Refugee,
			"female_tailor_background",
			"female_thief_background",
			::Legends.Background.Vagabond,
			::Legends.Background.Poacher
		];

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_nomad")
		{
			this.m.DraftList.push(::Legends.Background.Nomad);
			this.m.DraftList.push(::Legends.Background.NomadRanged);
		}
	}
});