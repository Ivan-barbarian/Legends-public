::Legends.Rune <- {}

::Legends.Runes <- {
	Target = {
		Shield = 64,
		Weapon = 2048,
		Helmet = 4096,
		Armor = 8192
	}
	Defs = {},
	add = function(_def) {
		local id = ::Legends.Rune.len() + 1;
		::Legends.Runes.Defs[id] <- _def;
		return id;
	}
	get = function(_const) {
		return ::Legends.Runes.Defs[_const];
	}
};
