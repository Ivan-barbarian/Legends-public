this.perk_legend_recuperation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendRecuperation);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onUpdate(_properties)
	{
		_properties.AdditionalHealingDays -= 1;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		if (actor.isAlive() && actor.getHitpointsPct() < 1.0)
		{
			local hp = ::Math.floor((actor.getHitpointsMax() - actor.getHitpoints()) * 0.3);
			actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), hp + actor.getHitpoints()));
			actor.setDirty(true);
		}
	}
});

