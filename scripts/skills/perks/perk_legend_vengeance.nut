this.perk_legend_vengeance <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0
	},
	function create() {
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendVengeance);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties ) {
		this.m.Stacks += 1;
	}

	function onUpdate(_properties) {
		if (this.m.Stacks > 0) {
			_properties.DamageTotalMult *= 1.2;
		}
	}

	function isHidden() {
		return this.m.Stacks == 0;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType ) {
		local actor = this.getContainer().getActor();
		if (_victim.getFaction() == actor.getFaction())
			this.m.Stacks++;
		else if (_victim.getFaction() == this.Const.Faction.PlayerAnimals && actor.getFaction() == this.Const.Faction.Player)
			this.m.Stacks++;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree ) {
		if (_skill.isAttack())
			this.m.Stacks -= 1;
	}

	function getDescription() {
		return "Having just received a blow, this character is determined to fight even harder! The next [color=%positive%]" + this.m.Stacks + "[/color] attacks will inflict [color=%positive%]20%[/color] more damage.";
	}

});

