::mods_hookExactClass("skills/actives/throw_spear_skill", function(o)
{
	o.m.AdditionalAccuracy <- 20;
	o.m.AdditionalHitChance <- -10;
	o.m.OverflowDamage <- 0;

	o.getTooltip = function ()
	{
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] throwing spears left"
			});
		}
		else
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]No throwing spears left[/color]"
			});
		}

		local damage = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/shield_damage.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage + "[/color] damage to shields"
		});

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	o.getAmmo <- function ()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	o.consumeAmmo <- function ()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	o.isUsable = function ()
	{

		local isUsable = !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		if (this.getContainer().hasPerk(::Legends.Perk.LegendCloseCombatArcher))
			return isUsable;

		return isUsable && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate(_properties);
		if (this.getContainer().hasPerk(::Legends.Perk.LegendCloseCombatArcher))
		{
			this.m.MinRange = 1;
			this.m.MaxRange = 3;
		}
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = 20 + this.m.Item.getAdditionalAccuracy();
	}

	o.calculateDamage <- function (_target)
	{
		local damage = this.getItem().getShieldDamage();
		local shield = _target.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield.getID() == "shield.legend_parrying_dagger" || shield.getID() == "shield.legend_named_parrying_dagger")
			damage *= 0.20;

		return this.Math.floor(damage);
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.consumeAmmo();
		local shield = target.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
		{
			local damage = this.calculateDamage(target);

			if (shield.getID() == "weapon.legend_parrying_dagger" || shield.getID() == "shield.legend_named_parrying_dagger")
			{
				damage *= 0.20;
			}
			local flip = !this.m.IsProjectileRotated && target.getPos().X > _user.getPos().X;
			local time = this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onApplyShieldDamage.bindenv(this), {
				User = _user,
				Skill = this,
				TargetTile = _targetTile,
				Shield = shield,
				Damage = damage
			});
		}
		else
		{
			local ret = this.attackEntity(_user, targetEntity);
		}
		return true;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			if (_properties.IsSpecializedInSpearThrust)
			{
				this.m.AdditionalHitChance += 10;
			}
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (_targetEntity != null)
			{
				local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

				if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
				{
					this.m.IsUsingHitchance = false;
				}
				else
				{
					this.m.IsUsingHitchance = true;
				}
			}
			else
			{
				this.m.IsUsingHitchance = true;
			}
			_properties.DamageRegularMin = this.m.OverflowDamage;
			_properties.DamageRegularMax = this.m.OverflowDamage;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;
		}
	}

	o.onApplyShieldDamage = function ( _tag )
	{
		local conditionBefore = _tag.Shield.getCondition();
		_tag.Shield.applyShieldDamage(_tag.Damage);
		local overflowDamage = this.Math.floor(_tag.Damage - conditionBefore);
		if (_tag.Shield != null && _tag.Shield.getCondition() == 0)
		{
			local logMessage = this.Const.UI.getColorizedEntityName(_tag.User) + " has destroyed " + this.Const.UI.getColorizedEntityName(_tag.TargetTile.getEntity()) + "\'s shield";
			if (this.getContainer().hasPerk(::Legends.Perk.LegendSmashingShields))
			{
				_tag.User.setActionPoints(this.Math.min(_tag.User.getActionPointsMax(), _tag.User.getActionPoints() + 4));
				this.Tactical.EventLog.log(logMessage + " and recovered 4 Action Points");
				if (overflowDamage > 0)
				{
					this.m.OverflowDamage = overflowDamage;
					this.attackEntity(_user, targetEntity);
					this.m.OverflowDamage = 0;
				}
			}
			else
			{
				this.Tactical.EventLog.log(logMessage);
			}
		}
		else
		{
			if (!_tag.User.isHiddenToPlayer() && _tag.TargetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_tag.TargetTile.getEntity()) + "\'s shield is hit for [b]" + (conditionBefore - _tag.Shield.getCondition()) + "[/b] damage");
			}

			if (_tag.Skill.m.SoundOnHitShield.len() != 0)
			{
				this.Sound.play(_tag.Skill.m.SoundOnHitShield[this.Math.rand(0, _tag.Skill.m.SoundOnHitShield.len() - 1)], this.Const.Sound.Volume.Skill, _tag.TargetTile.getEntity().getPos());
			}
		}

		if (!this.Tactical.getNavigator().isTravelling(_tag.TargetTile.getEntity()))
		{
			this.Tactical.getShaker().shake(_tag.TargetTile.getEntity(), _tag.User.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
				"shield_icon"
			], 1.0);
		}
	}
});
