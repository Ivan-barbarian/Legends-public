/**
* getTooltip - rune item tooltip
* getRuneTooltip - crafting tooltip
*/
::Legends.Rune.LegendRshClarity <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Helmet,
	Name = "Helmet Rune Sigil: Clarity",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshClarity,
	Script = "scripts/items/legend_helmets/runes/legend_rune_clarity",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(0, 2));
			_item.setRuneBonus2(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(0, 1));
			_item.setRuneBonus2(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Clarity:\n[color=%positive%]+" + _item.getRuneBonus1() + "[/color] Vision.\n[color=%positive%]+" + _item.getRuneBonus2() + "%[/color] Experience gain.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 2 : 1;
		local max2 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Clarity:\n[color=%positive%]0 to +" + max1 + "[/color] Vision.\n[color=%positive%]+3% to +" + max2 + "%[/color] Experience gain.";
	}
});

::Legends.Rune.LegendRshBravery <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Helmet,
	Name = "Helmet Rune Sigil: Bravery",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshBravery,
	Script = "scripts/items/legend_helmets/runes/legend_rune_bravery",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
			_item.setRuneBonus2(::Math.rand(1, 5));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
			_item.setRuneBonus2(::Math.rand(1, 3));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Bravery:\n[color=%positive%]+" + _item.getRuneBonus1() + "%[/color] Resolve.\n[color=%positive%]+" + _item.getRuneBonus2() + "[/color] Resolve at all morale checks.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		local max2 = _item.isUpgraded() ? 5 : 3;
		return "This item has the power of the rune sigil of Bravery:\n[color=%positive%]+3% to +" + max1 + "%[/color] Resolve.\n [color=%positive%]+1 to +" + max2 + "[/color] Resolve at all morale checks.";
	}
});

::Legends.Rune.LegendRshLuck <- ::Legends.Runes.add({
	ItemType = ::Legends.Runes.Target.Helmet,
	Name = "Helmet Rune Sigil: Luck",
	Description = "An inscribed rock that can be attached to a character\'s helmet.",
	Icon = "rune_sigils/rune_stone_2.png",
	IconLarge = "rune_sigils/rune_stone_2.png",
	Effect = ::Legends.Effect.LegendRshLuck,
	Script = "scripts/items/legend_helmets/runes/legend_rune_luck",
	setRuneBonus = function(_item, _bonus) {
		if (_bonus) {
			_item.setRuneBonus1(::Math.rand(3, 9));
		} else {
			_item.setRuneBonus1(::Math.rand(3, 6));
		}
	},
	getTooltip = function(_item) {
		return "This item has the power of the rune sigil of Luck:\n[color=%positive%]+" + _item.getRuneBonus1() + "%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
	}
	getRuneTooltip = function (_item) {
		local max1 = _item.isUpgraded() ? 9 : 6;
		return "This item has the power of the rune sigil of Luck:\n[color=%positive%]+3% to +" + max1 + "%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
	}
});
