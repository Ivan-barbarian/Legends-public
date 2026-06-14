::mods_hookExactClass("entity/world/settlements/situations/safe_roads_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.1);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.CaravanHand);
		_draftList.push(::Legends.Background.CaravanHand);
		_draftList.push(::Legends.Background.CaravanHand);
		_draftList.push(::Legends.Background.CaravanHand);
		_draftList.push(::Legends.Background.Sellsword);
		_draftList.push(::Legends.Background.Sellsword);
		_draftList.push(::Legends.Background.Vagabond);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Messenger);
		_draftList.push(::Legends.Background.Gambler);
		_draftList.push(::Legends.Background.Tailor);
		_draftList.push(::Legends.Background.Minstrel);
		_draftList.push(::Legends.Background.Historian);
		_draftList.push(::Legends.Background.AdventurousNoble);
		_draftList.push(::Legends.Background.AdventurousNoble);
		_draftList.push(::Legends.Background.LegendDonkey);

		if ( this.World.Assets.getOrigin().getID() == "scenario.legends_crusader") {
			_draftList.push(::Legends.Background.LegendPilgrim);
			_draftList.push(::Legends.Background.LegendPilgrim);
			_draftList.push(::Legends.Background.LegendPilgrim);
			_draftList.push(::Legends.Background.LegendPilgrim);
			_draftList.push(::Legends.Background.LegendPilgrim);
			_draftList.push(::Legends.Background.LegendPilgrim);
		}
		else if ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push(::Legends.Background.LegendManAtArms);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
		}
	}
});
