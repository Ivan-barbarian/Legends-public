::mods_hookExactClass("entity/world/settlements/situations/razed_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.20);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.Beggar);
		_draftList.push(::Legends.Background.Beggar);
		_draftList.push(::Legends.Background.Beggar);
		_draftList.push(::Legends.Background.Cripple);
		_draftList.push(::Legends.Background.Cripple);
		_draftList.push(::Legends.Background.Cripple);
		_draftList.push(::Legends.Background.Graverobber);
		_draftList.push(::Legends.Background.Raider);

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro") {
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
		}
		else if (this.World.Assets.getOrigin().getID() == "scenario.legends_berserker")
		{
			_draftList.push(::Legends.Background.LegendBerserker);
		}
	}
});
