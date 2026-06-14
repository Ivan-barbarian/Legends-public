::mods_hookExactClass("entity/world/settlements/situations/mustering_troops_situation", function(o)
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
		_draftList.push(::Legends.Background.RetiredSoldier);
		_draftList.push(::Legends.Background.Cripple);
		_draftList.push(::Legends.Background.Cripple);
		_draftList.push(::Legends.Background.Deserter);
		_draftList.push(::Legends.Background.Deserter);

		if (this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push(::Legends.Background.LegendManAtArms);
			_draftList.push(::Legends.Background.LegendManAtArms);
			_draftList.push(::Legends.Background.LegendManAtArms);
		}

	}
});
