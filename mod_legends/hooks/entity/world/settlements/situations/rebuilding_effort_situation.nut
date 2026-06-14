::mods_hookExactClass("entity/world/settlements/situations/rebuilding_effort_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.05);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		if (this.m.IsSouthern) { // Necro: "this.m.IsSouthern" is always false, i don't get how this would work
			_draftList.push(::Legends.Background.DaytalerSouthern);
			_draftList.push(::Legends.Background.DaytalerSouthern);
			_draftList.push(::Legends.Background.DaytalerSouthern);
			_draftList.push(::Legends.Background.DaytalerSouthern);
			_draftList.push(::Legends.Background.SlaveSouthern);
			_draftList.push(::Legends.Background.SlaveSouthern);
			_draftList.push(::Legends.Background.SlaveSouthern);
			_draftList.push(::Legends.Background.SlaveSouthern);
			_draftList.push(::Legends.Background.SlaveSouthern);
			_draftList.push(::Legends.Background.SlaveSouthern);

		}
		else {
			_draftList.push(::Legends.Background.Lumberjack);
			_draftList.push(::Legends.Background.Lumberjack);
			_draftList.push(::Legends.Background.Mason);
			_draftList.push(::Legends.Background.Mason);
			_draftList.push(::Legends.Background.Daytaler);
			_draftList.push(::Legends.Background.Daytaler);
			_draftList.push(::Legends.Background.Daytaler);
			_draftList.push(::Legends.Background.LegendInventor);
		}

		_draftList.push(::Legends.Background.LegendBlacksmith);
		_draftList.push(::Legends.Background.LegendBlacksmith);
		_draftList.push(::Legends.Background.LegendBlacksmith);
	}
});
