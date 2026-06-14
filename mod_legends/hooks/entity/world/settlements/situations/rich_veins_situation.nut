::mods_hookExactClass("entity/world/settlements/situations/rich_veins_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.25);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.Miner);
		_draftList.push(::Legends.Background.Miner);
		_draftList.push(::Legends.Background.Miner);
		_draftList.push(::Legends.Background.Miner);
		_draftList.push(::Legends.Background.LegendIronmonger);
		_draftList.push(::Legends.Background.LegendIronmonger);
		_draftList.push(::Legends.Background.LegendBlacksmith);
	}
});
