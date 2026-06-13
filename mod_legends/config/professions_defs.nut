if (!("Professions" in ::Const)) {
	::Const.Professions <- {};
}

if (!("Profession" in ::Legends)) {
	::Legends.Profession <- {};
}

::Const.Professions.ProfessionDefObjects <- [];
::Const.Professions.ProfessionDefs <- {};

/**
 * @param _professionDefObjects is an array of profession definitions
 * @param _container is namespace where ids will reside, you can use your own in submods
 */

::Const.Professions.addProfessionDefObjects <- function (_professionDefObjects, _container = ::Legends.Profession) {
	local size = ::Const.Professions.ProfessionDefObjects.len();
	::Const.Professions.ProfessionDefObjects.extend(_professionDefObjects);
	foreach (i, professionDefObject in _professionDefObjects) {
		if (professionDefObject.Const in _container) {
			_container[professionDefObject.Const] = size + i;
		} else {
			_container[professionDefObject.Const] <- size + i;
		}
		::Const.Professions.ProfessionDefs[professionDefObject.Const] <- size + i;
		::Const.Professions.LookupMap[professionDefObject.ID] <- professionDefObject;
	}
}

local professionDefObjects = [];

// Professions go here
professionDefObjects.push({
	ID = "profession.legend_hunting",
	Script = "scripts/skills/professions/profession_legend_hunting",
	Name = ::Const.Strings.ProfessionName.LegendHunting,
	Tooltip = ::Const.Strings.ProfessionDescription.LegendHunting,
	Icon = "ui/professions/hunting.png",
	IconDisabled = "ui/professions/hunting_bw.png",
	Const = "LegendHunting"
});

::Legends.Profession.LegendWoodworking <- null;
professionDefObjects.push({
	ID = "profession.legend_woodworking",
	Script = "scripts/skills/professions/profession_legend_woodworking",
	Name = ::Const.Strings.ProfessionName.LegendWoodworking,
	Tooltip = ::Const.Strings.ProfessionDescription.LegendWoodworking,
	Icon = "ui/professions/woodworking.png",
	IconDisabled = "ui/professions/woodworking_bw.png",
	Const = "LegendWoodworking"
});

::Const.Professions.addProfessionDefObjects(professionDefObjects);
