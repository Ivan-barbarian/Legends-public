this.profession_legend_hunting <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendHunting);
	}
});
