this.perk_legend_grappler <- this.inherit("scripts/skills/skill", {
	m = {
		GrappleChance = 25,
		DisarmChance = 50
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendGrappler);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendChoke))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendChoke);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendChoke);
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() != ::Legends.Actives.getID(::Legends.Active.HandToHand))
			return;

		if (this.Math.rand(1, 100) <= this.m.GrappleChance)
		{
			if (_targetEntity.isAlive() && !_targetEntity.isDying())
			{
				::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendGrappled);
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has grappled " + this.Const.UI.getColorizedEntityName(_targetEntity) + " for two turns");
				}
				if ((this.Math.rand(1, 100) > this.m.DisarmChance || _user.getCurrentProperties().IsSpecializedInFists) && !_targetEntity.getCurrentProperties().IsImmuneToDisarm)
				{
					::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Disarmed);
				}
			}
		}
	}
});

