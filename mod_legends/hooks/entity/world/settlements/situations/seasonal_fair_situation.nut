::mods_hookExactClass("entity/world/settlements/situations/seasonal_fair_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Rumors.push("Big fairs like the one over in %settlement% atract the worst kinds of people, minstrels and troubadours.");
	}

	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.1);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList = function ( _draftList )
	{
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Peddler);
		_draftList.push(::Legends.Background.Juggler);
		_draftList.push(::Legends.Background.Juggler);
		_draftList.push(::Legends.Background.Juggler);
		_draftList.push(::Legends.Background.Minstrel);
		_draftList.push(::Legends.Background.Minstrel);
		_draftList.push(::Legends.Background.Minstrel);
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);
		_draftList.push(::Legends.Background.LegendMasterArcher);

		if ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
		}
		else if ( this.World.Assets.getOrigin().getID() == "scenario.legends_troupe") {
			_draftList.push(::Legends.Background.LegendIllusionist);
		}
	}
});
