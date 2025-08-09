foreach(event in [
	"apprentice_learns_event",
	"jousting_tournament_event",
	"traveling_troupe_event",
	//town encounters
  "bad_curse_event",
  "ball_on_roof_event",
  "cat_on_tree_event",
  "creepy_guy_event",
  "enter_friendly_town_event",
	"enter_unfriendly_town_event",
	"eunuch_ladies_event",
	"graverobber_heist_event",
	"inadvertently_save_merchant_event",
	"juggler_entertains_townsfolk_event",
	"lend_men_to_build_event",
	"master_no_use_apprentice_event",
	"melon_thief_event",
	"surefooted_saves_damsel_event",
	"troublemakers_bully_peasants_event",
	"wildman_causes_havoc_event",
	"apprentice_learns_event",
	"bad_curse_event",
]) {
	::mods_hookExactClass("events/events/" + event, function(o) {
		o.m.isValidForEncounter <- false;

		local onUpdateScore = o.onUpdateScore;
		o.onUpdateScore = function() {
			onUpdateScore();
			this.m.isValidForEncounter = this.m.Score > 0 && this.Time.getVirtualTimeF() > this.m.CooldownUntil;
			this.m.Score = 0; // this disables event from happening normally
		}
	})
}
