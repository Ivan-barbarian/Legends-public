::Legends.Rune <- {}

::Legends.Runes <- {
	Target = {
		Shield = ::Const.Items.ItemType.Shield,
		Weapon = ::Const.Items.ItemType.Weapon,
		Helmet = ::Const.Items.ItemType.Helmet,
		Armor = ::Const.Items.ItemType.Armor
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
