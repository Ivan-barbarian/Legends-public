this.legend_troublemakers_bully_peasants_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_troublemakers_bully_peasants_encounter";
        this.m.Name = "{While at %settlement... | Strolling through %settlement% | Something\'s up at %settlement}";
		this.m.Event = "event.trouble_makers_bully_peasants";
    }
})
