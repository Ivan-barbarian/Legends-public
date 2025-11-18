/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRssDefense <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Shield,
	Name = "Shield Rune Sigil: Defense",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssDefense,
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
		return "This item has the power of the rune sigil of Defense:\n[color=%positive%]+" + _item.getRuneBonus1() + "%[/color] Melee defense.\n" + "[color=%positive%]+" + _item.getRuneBonus2() + "%[/color] Ranged defense.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Defense:\n[color=%positive%]+3% to +" + max1 + "%[/color] Melee defense.\n" + "[color=%positive%]+3% to +" + max1 + "%[/color] Ranged defense.";
	}
});

::Legends.Rune.LegendRssRadiance <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Shield,
	Name = "Shield Rune Sigil: Radiance",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssRadiance,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 12));
			_item.setRuneBonus2(::Math.rand(3, 12));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(3, 9));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Radiance:\n[color=%positive%]-" + _item.getRuneBonus1() + "%[/color] to all adjacent enemies\' Melee skill.\n" + "[color=%positive%]-" + _item.getRuneBonus2() + "%[/color] to all adjacent enemies\' Melee defense.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Radiance:\n[color=%positive%]-3% to -" + max1 + "%[/color] to all adjacent enemies\' Melee skill.\n" + "[color=%positive%]-3% to -" + max1 + "%[/color] to all adjacent enemies\' Melee defense.";
	}
});



