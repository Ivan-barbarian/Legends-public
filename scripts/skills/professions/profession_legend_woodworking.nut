this.profession_legend_woodworking <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendWoodworking);
	}
});
