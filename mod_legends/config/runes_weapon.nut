/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRswPower <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Power",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswPower,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Power:\n[color=%positive%]+" + _item.getRuneBonus1() + "%[/color] Damage inflicted.\n" + "[color=%positive%]+" + _item.getRuneBonus2() + "[/color] Max damage.";
	},
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Power:\n[color=%positive%]+3% to +" + max1 + "%[/color] total damage inflicted and [color=%positive%]+3 to +" + max2 + "[/color] maximum damage.";
	}
});

::Legends.Rune.LegendRswAccuracy <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Accuracy",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswAccuracy,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Accuracy:\n[color=%positive%]+" + _item.getRuneBonus1() + "%[/color] Melee skill.\n" + "[color=%positive%]+" + _item.getRuneBonus2() + "%[/color] Ranged skill.";
	},
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Accuracy:\n[color=%positive%]+3% to +" + max1 + "%[/color] Melee skill.\n" + "[color=%positive%]+3% to +" + max1 + "%[/color] Ranged skill.";
	}
});

::Legends.Rune.LegendRswFeeding <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Feeding",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswFeeding,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(2, 6));
		} else {
			_item.setRuneBonus1(::Math.rand(2, 4));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Feeding:\n[color=%positive%]" + _item.getRuneBonus1() + "%[/color] of inflicted health damage recovers fatigue.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 6 : 4;
		return "This item has the power of the rune sigil of Feeding:\n[color=%positive%]2% to " + max1 + "%[/color] of inflicted health damage recovers fatigue.";
	}
});

::Legends.Rune.LegendRswPoison <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Poison",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswPoison,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(1, 3));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(1, 2));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Poison:\n[color=%positive%]" + _item.getRuneBonus1() + "[/color] turn(s) of poison applied, with a strength of [color=%positive%]" + _item.getRuneBonus2() + "[/color]. Lowers action points and initiative.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 3 : 2;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Poison:\n[color=%positive%]1 to " + max1 + "[/color] turn(s) of poison applied, with a strength of [color=%positive%]3 to " + max2 + "[/color]. Lowers action points and initiative.";
	}
});

::Legends.Rune.LegendRswBleeding <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Bleeding",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswBleeding,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Bleeding:\n[color=%positive%]" + _item.getRuneBonus1() + "[/color] bleed damage every turn for [color=%positive%]" + _item.getRuneBonus2() + "[/color] turn(s).";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		local max2 = _item.isUpgraded() ? 3 : 2;
		return "This item has the power of the rune sigil of Bleeding:\n[color=%positive%]3 to " + max1 + "[/color] bleed damage every turn for [color=%positive%]1 to " + max2 + "[/color] turn(s).";
	}
});

::Legends.Rune.LegendRswUnbreaking <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Unbreaking",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswUnbreaking,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Unbreaking:\n[color=%positive%]" + _item.getRuneBonus1() + "[/color] to [color=%positive%]" + _item.getRuneBonus2() + "[/color] durability restored on every kill.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 3 : 2;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Unbreaking:\n[color=%positive%]" + max1 + "[/color] to [color=%positive%]" + max2 + "[/color] durability restored on every kill.";
	}
});

::Legends.Rune.LegendRswBlazing <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Weapon,
	Name = "Weapon Rune Sigil: Blazing",
	Description = "An inscribed rock that can be attached to a character\'s weapon.",
	Icon = "rune_sigils/rune_stone_1.png",
	IconLarge = "rune_sigils/rune_stone_1.png",
	Effect = ::Legends.Effect.LegendRswBlazing,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 10));
			_item.setRuneBonus2(::Math.rand(1, 3));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 2));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Blazing:\nOn hit sets tile on fire causing [color=%damage%]" + _item.getRuneBonus1() + "[/color] Damage for [color=%positive%]" + _item.getRuneBonus2() + "[/color] turns to anyone standing on it.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		local max2 = _item.isUpgraded() ? 3 : 2;
		return "This item has the power of the rune sigil of Blazing:\nOn hit sets tile on fire causing [color=%damage%]3[/color] to [color=%damage%]" + max1 + "[/color] for [color=%positive%]1[/color] to [color=%positive%]" + max2 + "[/color] turns to anyone standing on it.";
	}
});
