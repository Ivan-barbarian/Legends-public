this.perk_legend_strength_in_numbers <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendStrengthInNumbers);
	}

	function onUpdate( _properties )
	{
		_properties.SurroundedBonusMult = 2.0;
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local count = 0;

		foreach( ally in allies ) {
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap()) {
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) <= 2) {
				count += 1;
			}
		}
		_properties.MeleeDefense += count * 2;
		_properties.RangedDefense += count * 2;
	}

});

