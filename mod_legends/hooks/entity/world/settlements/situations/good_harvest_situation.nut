::mods_hookExactClass("entity/world/settlements/situations/good_harvest_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.1);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.Farmhand);
		_draftList.push(::Legends.Background.Farmhand);
		_draftList.push(::Legends.Background.Farmhand);
		_draftList.push(::Legends.Background.Farmhand);
		_draftList.push(::Legends.Background.Miller);
		_draftList.push(::Legends.Background.Miller);
		_draftList.push(::Legends.Background.LegendHerbalist);
	}
});
