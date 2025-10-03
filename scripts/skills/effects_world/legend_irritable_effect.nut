this.legend_irritable_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {
		JustCooldown = false
	},

	function create()
	{
		this.injury.create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendIrritable);
		this.m.Description = "Repeated attempts to study have made this character more than irritable. The negative effects will disappear by the next day, but this effect is not treatable and prevents the character from reading books and scrolls.";
		this.m.Icon = "skills/status_effect_62.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect | this.Const.SkillType.SemiInjury;
		this.m.IsHealingMentioned = true;
		this.m.IsTreatable = false;
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (!this.m.JustCooldown)
		{
			ret.extend([
				{
					id = 13,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Resolve"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Melee Skill"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Ranged Skill"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Melee Defense"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Ranged Defense"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Initiative"
				}
			]);
		}
		this.addTooltipHint(ret);
		return ret;
	}

	function addHealingTime( _days )
	{
		local days = _days;
		if (::Legends.Traits.has(this, ::Legends.Trait.Dumb))
			days *= 2;
		if (this.getContainer().hasSkill("injury.brain_damage"))
			days *= 2;
		if (::Legends.Perks.has(this, ::Legends.Perk.Student))
			this.Math.floor(days /= 1.5);
		if (::Legends.Traits.has(this, ::Legends.Trait.Bright))
			this.Math.floor(days /= 2);
		this.m.HealingTimeMin = this.Math.max(1, this.m.HealingTimeMin + days);
		this.m.HealingTimeMax = this.Math.max(this.m.HealingTimeMin + 1, this.m.HealingTimeMax + days);
	}

	function onAdded()
	{
		if (!this.m.JustCooldown)
			this.injury.onAdded();
	}

	function onNewDay()
	{
		this.injury.onNewDay();
		this.m.JustCooldown = true;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		if (this.m.JustCooldown)
			return;
		_properties.BraveryMult *= 0.85;
		_properties.MeleeSkillMult *= 0.85;
		_properties.RangedSkillMult *= 0.85;
		_properties.MeleeDefenseMult *= 0.85;
		_properties.RangedDefenseMult *= 0.85;
		_properties.InitiativeMult *= 0.85;
	}

});

