this.legend_additional_padding_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_additional_padding";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Additional Fur Padding";
		this.m.Description = "Crafted from thick furs, this additional padding helps dampen the impact of any blow. Can be worn atop any armor to make the wearer more resilient against ranged weapons and stop blows penetrating the armor";
		this.m.ArmorDescription = "Additional fur padding helps to further dampen the impact of any blow.";
		this.m.Icon = "armor_upgrades/upgrade_03.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_03.png";
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_03.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_03.png";
		this.m.SpriteFront = "upgrade_03_front";
		this.m.SpriteBack = "upgrade_03_back";
		this.m.SpriteDamagedFront = "upgrade_03_front_damaged";
		this.m.SpriteDamagedBack = "upgrade_03_back";
		this.m.SpriteCorpseFront = "upgrade_03_front_dead";
		this.m.SpriteCorpseBack = "upgrade_03_back_dead";

		this.m.Value = 1200;
		this.m.Condition = 5;
		this.m.ConditionMax = 5;
		this.m.StaminaModifier = -1;
		this.m.DirectDamageModifier = -15.0;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=%negative%]-10%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage to the body by [color=%negative%]-10%[/color]"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedRangedMult *= 0.9;
		}
	}
});

