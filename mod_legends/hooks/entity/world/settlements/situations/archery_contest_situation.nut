::mods_hookExactClass("entity/world/settlements/situations/archery_contest_situation", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _draftList )
	{
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);

		// if (_gender)
		// {
		// 	_draftList.push("female_adventurous_noble_background");
		// 	_draftList.push("female_adventurous_noble_background");
		// 	_draftList.push("female_disowned_noble_background");

		// }

		onUpdateDraftList(_draftList);
	}
});
