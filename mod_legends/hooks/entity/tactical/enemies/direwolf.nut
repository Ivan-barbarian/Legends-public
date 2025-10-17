::mods_hookExactClass("entity/tactical/enemies/direwolf", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
			::Legends.Traits.grant(this, ::Legends.Trait.RacialLegendWerewolf);
		}
	}

	o.setVariant <- function (_v, _c, _s, _hp = 1.0)
	{
		m.Items.getAppearance().Body = "bust_direwolf_0" + _v;
		m.Items.getAppearance().Armor = "bust_wolf_02_armor_01";

		local body = getSprite("body");
		body.setBrush("bust_wolf_0" + _v + "_body");
		body.Color = _c;
		body.Saturation = _s;

		local head = getSprite("head");
		head.setBrush("bust_wolf_0" + _v + "_head");
		head.Color = _c;
		head.Saturation = _s;

		getSprite("armor").Visible = true;

		if(_hp != 1.0)
		{
			m.Hitpoints = getHitpointsMax() * _hp;
			onUpdateInjuryLayer();
		}
		else
		{
			setDirty(true);
		}
	}
});
