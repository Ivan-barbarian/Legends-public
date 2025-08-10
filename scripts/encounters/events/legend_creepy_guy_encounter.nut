this.legend_apprentice_learns_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_creepy_guy_encounter";
        this.m.Name = "{While at %settlement... | Strolling through %settlement% | Something\'s up at %settlement}"";
		this.m.Event = "event.creepy_guy";
    }
})
