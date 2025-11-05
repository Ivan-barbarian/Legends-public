this.encounter_event <- this.inherit("scripts/encounters/encounter", {
	/** Base convenience class for encounters that fire event. */
	m = {
		Event = null
	}

	function isValid(_settlement) {
		local event = ::World.Events.getEvent(this.m.Event);
		if (event == null) {
			return false;
		}
		event.m.Score = 0;
		event.onUpdateScore();
		return event.m.isValidForEncounter;
	}
});
