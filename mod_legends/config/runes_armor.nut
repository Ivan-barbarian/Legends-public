/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRsaEndurance <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Armor,
	Name = "Armor Rune Sigil: Endurance",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaEndurance,
	Script = "scripts/items/legend_armor/runes/legend_rune_endurance",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(0, 3));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(0, 1));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Endurance:\n[color=%positive%]+" + _item.getRuneBonus1() + "[/color] Fatigue recovery per turn.\n[color=%positive%]-" + _item.getRuneBonus2() + "%[/color] Fatigue cost and effects multiplier.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 3 : 1;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Endurance:\n[color=%positive%]+0 to +" + max1 + "[/color] Fatigue recovery per turn.\n[color=%positive%]-3% to -" + max2 + "%[/color] Fatigue cost and effects multiplier.";
	}
});

::Legends.Rune.LegendRsaSafety <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Armor,
	Name = "Armor Rune Sigil: Safety",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaSafety,
	Script = "scripts/items/legend_armor/runes/legend_rune_safety",
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
		return "This item has the power of the rune sigil of Safety:\n[color=%positive%]+" + _item.getRuneBonus1() + "%[/color] Hitpoints.\n[color=%positive%]-" + _item.getRuneBonus2() + "%[/color] Damage received.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Safety:\n[color=%positive%]+3% to +" + max1 + "%[/color] Hitpoints.\n[color=%positive%]-3% to -" + max1 + "%[/color] Damage received.";
	}
});

::Legends.Rune.LegendRsaResilience <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Armor,
	Name = "Armor Rune Sigil: Resilience",
	Description = "An inscribed rock that can be attached to a character\'s armor.",
	Icon = "rune_sigils/rune_stone_3.png",
	IconLarge = "rune_sigils/rune_stone_3.png",
	Effect = ::Legends.Effect.LegendRsaResilience,
	Script = "scripts/items/legend_armor/runes/legend_rune_resilience",
	setRuneBonus = function(_item, _bonus) {},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Resilience:\n[color=%positive%]Immune[/color] to stuns, knockbacks and grabs.";
	}
	getRuneTooltip = function (_item) {
		// Removed 22/1/23 as part of the steel brow rework. May rework this rune in a similar manner later where its not blanket immunity
		// return "This item has the power of the rune sigil of Resilience:\n[color=%positive%]Immune[/color] to stuns, knockbacks and grabs.";
		return "This rune is not supposed to drop, if you see this, post bug report."
	}
});
