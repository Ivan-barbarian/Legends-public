::mods_hookExactClass("entity/world/settlements/situations/ceremonial_season_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.01);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.Monk);
		_draftList.push(::Legends.Background.Monk);
		_draftList.push(::Legends.Background.Cultist);
		_draftList.push(::Legends.Background.Flagellant);

		if ( this.World.Assets.getOrigin().getID() == "scenario.cultists") {
			_draftList.push(::Legends.Background.LegendHusk);
			_draftList.push(::Legends.Background.LegendHusk);
			_draftList.push(::Legends.Background.LegendLurker);
			_draftList.push(::Legends.Background.LegendLurker);
			_draftList.push(::Legends.Background.LegendLurker);
			_draftList.push(::Legends.Background.LegendMagister);
		}
		else if ( this.World.Assets.getOrigin().getID() == "scenario.legends_crusader") {
			for (local i = 0; i < 17; ++i)
			{
				_draftList.push(::Legends.Background.LegendPilgrim);
			}
		}
	}
});
