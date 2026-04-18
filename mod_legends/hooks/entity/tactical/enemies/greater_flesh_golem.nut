::mods_hookExactClass("entity/tactical/enemies/greater_flesh_golem", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBoneBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendAmbidextrous);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPugilist);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendGrappler);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPummelIntoSubmission);
		}
	}

	o.makeMiniboss <- function () {
		if (!this.actor.makeMiniboss()) {
			return false;
		}
		this.getSprite("miniboss").setBrush("bust_miniboss_undead");

		return true;
	}
});
