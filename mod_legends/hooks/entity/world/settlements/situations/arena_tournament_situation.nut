::mods_hookExactClass("entity/world/settlements/situations/arena_tournament_situation", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _draftList )
	{
		onUpdateDraftList(_draftList);
		_draftList.push(::Legends.Background.LegendGladiatorPrizefighter);
		_draftList.push(::Legends.Background.LegendGladiatorPrizefighter);
		_draftList.push(::Legends.Background.LegendGladiatorPrizefighter);
		_draftList.push(::Legends.Background.LegendGladiatorPrizefighter);
	}

});
