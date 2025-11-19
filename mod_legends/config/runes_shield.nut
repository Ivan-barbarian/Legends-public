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

::Legends.Rune.LegendRssDurability <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Shield,
	Name = "Shield Rune Sigil: Durability",
	Description = "An inscribed rock that can be attached to a character\'s shield.",
	Icon = "rune_sigils/rune_stone_4.png",
	IconLarge = "rune_sigils/rune_stone_4.png",
	Effect = ::Legends.Effect.LegendRssDurability,
	Script = "scripts/items/rune_sigils/legend_vala_inscription_token",
	Flag = "LegendRuneExtraDurability"
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9) * 3); // 9, 12 ... 27
			_item.setRuneBonus2(::Math.rand(5, 8) * 5); // 25, 30 ... 40%
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6) * 3); // 9, 12 ... 18
			_item.setRuneBonus2(::Math.rand(3, 6) * 5); // 15, 20 ... 30%
		}
	},
	getTooltip = function(_item) {
		return ::Legends.tooltip(@"
This item has the power of the rune sigil of Durability:
[color=%positive%]+%bonus1%[/color] additional Durability added to shield.
[color=%positive%]%bonus2%%[/color] chance to mitigate damage to shield.
		", [
			["bonus1", _item.getRuneBonus1()],
			["bonus2", _item.getRuneBonus2()]
		]);
	}
	getRuneTooltip = function (_item) {
		return ::Legends.tooltip(@"
This item has the power of the rune sigil of Durability:
[color=%positive%]+%min1%[/color] to [color=%positive%]+%max1%[/color] additional Durability added to shield.
[color=%positive%]%min2%%[/color] to [color=%positive%]%max2%%[/color] chance to mitigate damage to shield.
		", [
			["min1", 3 * (_item.isUpgraded() ? 3 : 3)],
			["max1", 3 * (_item.isUpgraded() ? 9 : 6)],
			["min2", 5 * (_item.isUpgraded() ? 5 : 3)],
			["max2", 5 * (_item.isUpgraded() ? 8 : 6)]
		]);
	}
});



