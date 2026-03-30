::mods_hookExactClass("entity/tactical/enemies/lindwurm", function(o)
{
	o.m.DroppableRunes <- [
		::Legends.Rune.LegendRsaEndurance,
		::Legends.Rune.LegendRsaSafety
	];
	o.m.EffectsSharedWithTail <- {
    		"effects.staggered": "scripts/skills/effects/staggered_effect",
    		"effects.dazed": "scripts/skills/effects/dazed_effect",
    		"effects.legend_baffled": "scripts/skills/effects/legend_baffled_effect",
			"effects.withered": "scripts/skills/effects/withered_effect",
			"effects.insect_swarm": "scripts/skills/effects/insect_swarm_effect",
			"effects.legend_dazed": "scripts/skills/effects/legend_dazed_effect"
	}

	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
		{
			this.m.OnDeathLootTable.push([1, function () {
				local selected = this.m.DroppableRunes[::Math.rand(0, this.m.DroppableRunes.len() - 1)];
				local rune = ::new(::Legends.Runes.get(selected).Script);
				rune.setRuneVariant(selected);
				rune.setRuneBonus(true);
				rune.updateRuneSigilToken();
				return rune;
			}.bindenv(this)]);
		}
	}

	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.remove(this, ::Legends.Perk.HoldOut);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);

		}
		local skills = this.getSkills();
		local skills_add = skills.add;
		skills.add = function( _skill, _order = 0 )
		{
			skills_add(_skill, _order);

			local actor = this.getActor();
			if (_skill.getID() in actor.m.EffectsSharedWithTail && actor.m.Tail != null && actor.m.Tail.isAlive()) {
				local tempEffect = ::new(actor.m.EffectsSharedWithTail[_skill.getID()]);
				tempEffect.m.IsFromHead <- true;
				actor.m.Tail.getSkills().add(tempEffect);
			}
		}.bindenv(skills);
	}
});
