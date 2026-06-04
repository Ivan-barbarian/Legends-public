this.perk_legend_adaptive <- this.inherit("scripts/skills/skill", {
	m = {
		HpBefore = 0,
		HpDamageReceived = 0,
		HpBeforeAttack = 0,
		Injuries = [],
		InjuriesCountThisBattle = 0,
		LifetimeInjuries = 0,
		Bonus = 0
	},
	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendNearDeathExperience);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function getTooltip() {
		if (bodyitem == null && headitem == null)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=%positive%]" + fm + "%[/color] of any damage to hitpoints from attacks"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]This character isn\'t nude.[/color]"
			});
		}

		return tooltip;
	}

	function isHidden() {
		return this.m.Bonus < 1;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties ) {
		this.m.Injuries.extend(this.getContainer().query(this.Const.SkillType.Injury));
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) {
			return;
		}

		local chance = this.getChance();
		_properties.DamageReceivedRegularMult *= (1.0 - this.m.Bonus * 0.05);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor ) {
		this.m.HpDamageReceived += _damageHitpoints;
	}

	function onAfterDamageReceived() {
		local num = this.getContainer().query(this.Const.SkillType.Injury).len() - this.m.Injuries.len();
		if (num > 0) {
			this.m.InjuriesCountThisBattle += num;
		}
	}

	function onUpdate ( _properties ) {
		this.m.Bonus = this.Math.min(6, this.getContainer().query(this.Const.SkillType.Injury).len());
		_properties.Bravery += this.Math.floor(this.m.Bonus * 3);
	}

	function onCombatStarted() {
		this.m.HpDamageReceived = 0;
		this.m.InjuriesCountThisBattle = 0
		this.m.HpBefore = this.getContainer().getActor().getHitpoints();
	}

	function onCombatFinished() {
		this.m.LifetimeInjuries = this.m.InjuriesCountThisBattle;
		local actor = this.getContainer().getActor();
		local xp = this.m.HpDamageReceived + (this.m.InjuriesCountThisBattle * 20);
		if (actor.getLevel() >= 12) {
			xp *= 0.1;
		}
		actor.addXP(xp);
		actor.updateLevel();
		this.m.InjuriesCountThisBattle = 0;
		this.m.HpDamageReceived = 0;
		this.m.InjuriesCountThisBattle = 0
	}

});
