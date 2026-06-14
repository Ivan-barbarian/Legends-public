::mods_hookExactClass("entity/world/settlements/small_swamp_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Beggar,
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			::Legends.Background.Daytaler,
			::Legends.Background.Daytaler,
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			"female_beggar_background",
			::Legends.Background.Cultist,
			::Legends.Background.Cultist,
			"female_daytaler_background",
			"female_daytaler_background",
			::Legends.Background.Flagellant,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Ratcatcher,
			::Legends.Background.Vagabond,
			::Legends.Background.Wildman,
			::Legends.Background.Wildman,
			::Legends.Background.Witchhunter,
			::Legends.Background.BeastSlayer
		];
	}
});