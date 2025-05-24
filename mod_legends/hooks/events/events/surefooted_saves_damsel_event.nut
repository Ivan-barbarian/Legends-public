::mods_hookExactClass("events/events/surefooted_saves_damsel_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_85.png[/img]A few mercenaries come back to you with the most curious of stories. Apparently %surefooted%, the ever surefooted sellsword, managed to make a bit of a name for himself in %townname%.\n\n While carousing with ladies on a tavern staircase, the bannister broke and a damsel went careening downward. With a horn of ale in one hand and a wench wrapped in the tender grip of the other, the mercenary stuck his foot out and managed to catch the falling mistress on the toe of his boot, quite literally bringing her to heel much to the roaring applause of the inebriated crowd below. You ask where he is now. The mercenaries laugh.%SPEECH_ON%Dropping trou with the easily impressed, what else?%SPEECH_OFF%";
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		onUpdateScore();
		if (this.m.Surefooted != null)
		{
			if (this.m.Surefooted.getGender() == 0)
			{
				return;
			}
		}
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 2 && bro.getSkills().hasSkill("trait.sure_footing") && bro.getGender() == 0)
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Surefooted = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = candidates.len() * 15;
	}
});
