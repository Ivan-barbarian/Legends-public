::mods_hookExactClass("entity/world/settlements/small_lumber_village", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DraftList = [
			::Legends.Background.Apprentice,
			::Legends.Background.Bowyer,
			::Legends.Background.Bowyer,
			::Legends.Background.Butcher,
			::Legends.Background.Daytaler,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Wildman,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			::Legends.Background.Tailor,
			::Legends.Background.Apprentice,
			"female_bowyer_background",
			"female_bowyer_background",
			"female_butcher_background",
			"female_daytaler_background",
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Lumberjack,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Poacher,
			::Legends.Background.Wildman,
			::Legends.Background.Hunter,
			::Legends.Background.Hunter,
			"female_tailor_background",
			::Legends.Background.BeastSlayer
		];
	}
});