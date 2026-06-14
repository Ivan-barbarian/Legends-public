::mods_hookExactClass("entity/world/settlements/situations/mine_cavein_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.05);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.LegendIronmonger);
		_draftList.push(::Legends.Background.LegendIronmonger);
		_draftList.push(::Legends.Background.LegendIronmonger);
		_draftList.push(::Legends.Background.LegendBlacksmith);

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro") {
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
		}
	}
});
