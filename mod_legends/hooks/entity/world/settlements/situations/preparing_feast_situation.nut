::mods_hookExactClass("entity/world/settlements/situations/preparing_feast_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.01);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.Butcher);
		_draftList.push(::Legends.Background.Butcher);
		_draftList.push(::Legends.Background.Servant);
		_draftList.push(::Legends.Background.Servant);
		_draftList.push(::Legends.Background.Servant);
		_draftList.push(::Legends.Background.Eunuch);
	}
});
