this.legend_hew_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHew);
		this.m.Description = "A horizontal side strike performed with full force to devastating effect.";
		this.m.KilledString = "Hewed";
		this.m.Icon = "skills/active_20.png";
		this.m.IconDisabled = "skills/active_20_sw.png";
		this.m.Overlay = "active_20";
		this.m.SoundOnUse = [
			"sounds/combat/overhead_strike_01.wav",
			"sounds/combat/overhead_strike_02.wav",
			"sounds/combat/overhead_strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/overhead_strike_hit_01.wav",
			"sounds/combat/overhead_strike_hit_02.wav",
			"sounds/combat/overhead_strike_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 99;
		this.m.ChanceSmash = 0;
	}

	function getTooltip () {
		local tooltip = this.getDefaultTooltip();

		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 20 : 10;
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		return tooltip;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this) {
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 10;
		}
	}

	function onDamageDealt( _target, _skill, _hitInfo ) {
		this.named_weapon.onDamageDealt(_target, _skill, _hitInfo);
		local actor = this.getContainer().getActor();
		if (!_target.isAlive() || _target.isDying())
			return;

		_skill.spawnAttackEffect(_target.getTile(), this.Const.Tactical.AttackEffectChop);
		if (!actor.isAlive() || actor.isDying())
			return;

		if (!_target.isAlive() || _target.isDying()) {
			if (_target.getFlags().has("tail") || !_target.getCurrentProperties().IsImmuneToBleeding) {
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
			}
			else {
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
			}
		}
		else if (!_target.getCurrentProperties().IsImmuneToBleeding) {
			::Legends.Effects.grant(_target, ::Legends.Effect.Bleeding, function(_effect) {
				if (actor.getFaction() == this.Const.Faction.Player )
					_effect.setActor(this.getContainer().getActor());
				_effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 20 : 10);
			}.bindenv(this));
			this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
		}
		else {
			this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
		}
	}

});

