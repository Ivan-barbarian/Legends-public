this.legend_rune_patience <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "legend_helmet_upgrade.legend_rune_patience";
		this.m.Type = this.Const.Items.HelmetUpgrades.Rune;
		this.m.Name = "Helmet Rune Sigil: Patience";
		this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
		this.m.ArmorDescription = "Includes An inscribed rock that grants additional initiative bonuses.";
		this.m.Icon = "rune_sigils/rune_stone_2.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "layers/glow_runed_icon.png";
		this.m.OverlayIconLarge = "layers/glow_runed_icon.png";
		this.m.Sprite = "bust_legend_helmet_runed";
		this.m.Value = 1200;
		this.setRuneVariant(::Legends.Rune.LegendRshPatience);
		this.setRuneBonus(false); // false = unupgraded enchanter stats. true = upgraded enchanter stats
	}

	function updateVariant()
	{
	}

	function getTooltip()
	{
		local rune = ::Legends.Runes.get(this.getRuneVariant());
		local result = this.legend_helmet_upgrade.getTooltip();
		if (rune != null) {
			result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = rune.getTooltip(this)
			});
		}
		return result;
	}

	function onArmorTooltip( _result )
	{
		local rune = ::Legends.Runes.get(this.getRuneVariant());
		if (rune != null) {
			_result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = rune.getTooltip(this)
			});
		}
	}
});

