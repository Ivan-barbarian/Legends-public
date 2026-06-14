::mods_hookExactClass("entity/world/settlements/situations/cultist_procession_situation", function(o)
{
	o.onUpdateDraftList <- function ( _draftList )
	{
		for (local i = 0; i < 16; ++i)
		{
			_draftList.push(::Legends.Background.Cultist);
		}
		
		_draftList.push(::Legends.Background.Flagellant);
		_draftList.push(::Legends.Background.Butcher);

		if  ( this.World.Assets.getOrigin().getID() == "scenario.cultists") {
			_draftList.push(::Legends.Background.LegendHusk);
			_draftList.push(::Legends.Background.LegendHusk);
			_draftList.push(::Legends.Background.LegendLurker);
			_draftList.push(::Legends.Background.LegendLurker);
			_draftList.push(::Legends.Background.LegendLurker);
			_draftList.push(::Legends.Background.LegendLurker);
			_draftList.push(::Legends.Background.LegendMagister);
		}
	}
});
