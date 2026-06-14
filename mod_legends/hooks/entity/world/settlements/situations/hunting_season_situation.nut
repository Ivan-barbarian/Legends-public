::mods_hookExactClass("entity/world/settlements/situations/hunting_season_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.02);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.Hunter);
		_draftList.push(::Legends.Background.Hunter);
		_draftList.push(::Legends.Background.Poacher);
		_draftList.push(::Legends.Background.Poacher);
		_draftList.push(::Legends.Background.Poacher);
		_draftList.push(::Legends.Background.Poacher);
		_draftList.push(::Legends.Background.LegendTaxidermist);
		_draftList.push(::Legends.Background.LegendTaxidermist);
		_draftList.push(::Legends.Background.Houndmaster);
		_draftList.push(::Legends.Background.Houndmaster);
		_draftList.push(::Legends.Background.Butcher);
		_draftList.push(::Legends.Background.Butcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);
	}
});
