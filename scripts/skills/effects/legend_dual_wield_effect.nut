this.legend_dual_wield_effect <- this.inherit("scripts/skills/skill", {
	m = {
		MainHandSkill = null,
		OffHandSkill = null,
		OffhandWeight = 0,
		AmbidextrousBonus = 0.33,
		IsRefreshing = false,
		IsExecutingOffhand = false,
		NeedsRefresh = null,
		ExcludedSkills = [],
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDualWield);
		this.m.Name = "Dual Wielding";
		this.m.Description = "This character is wielding two weapons at once. The weight of the offhand weapon increases fatigue costs and reduces accuracy.";
		this.m.Icon = "skills/status_effect_75.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.ExcludedSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendDoubleSwing)
		];
	}

	function getTooltip() {
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.m.Name
			},
			{
				id = 2,
				type = "description",
				text = this.m.Description
			}
		];

		local ohSkill = this.m.OffHandSkill;
		if (ohSkill != null && !::MSU.isNull(ohSkill)) {
			ret.push({
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Follow-up attack: [color=%positive%]" + ohSkill.getName() + "[/color]"
			});
		}

		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Skills cost [color=%negative%]+" + this.m.OffhandWeight + "[/color] Fatigue"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "Skills have [color=%negative%]-" + this.m.OffhandWeight + "[/color] Melee Skill"
		});

		return ret;
	}

	function getOffhandWeight(_actor, _oh) {
		local weight = -_oh.getStaminaModifier();
		if (::Legends.Perks.has(_actor, ::Legends.Perk.LegendAmbidextrous)) {
			weight = ::Math.floor(weight * (1 - this.m.AmbidextrousBonus));
		}
		return weight;
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDoubleSwing);

		local items = actor.getItems();

		// Find and store the mainhand attack skill
		local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		if (mh != null) {
			local skill = ::Legends.Weapons.findPrimaryAttackSkill(actor, mh);
			if (skill != null) {
				this.m.MainHandSkill = ::MSU.asWeakTableRef(skill);
			}
		} else {
			this.m.MainHandSkill = null;
		}

		// Find and store the offhand attack skill
		local oh = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		if (oh != null) {
			local skill = ::Legends.Weapons.findPrimaryAttackSkill(actor, oh);
			if (skill != null) {
				this.m.OffHandSkill = ::MSU.asWeakTableRef(skill);
				this.m.OffhandWeight = getOffhandWeight(actor, oh);
			}
		} else {
			this.m.OffHandSkill = null;
			this.m.OffhandWeight = 0;
		}
	}

	function onRemoved() {
		local actor = this.getContainer().getActor();
		::Legends.Actives.remove(actor, ::Legends.Active.LegendDoubleSwing);
	}

	function onUpdate(_properties) {
		if (this.m.OffhandWeight <= 0) {
			return;
		}

		local actor = this.getContainer().getActor();
		foreach (skill in actor.getSkills().m.Skills) {
			if (skill.m.IsAttack && this.m.ExcludedSkills.find(skill.getID()) == null) {
				_properties.SkillCostAdjustments.push({
					ID = skill.getID(),
					FatigueAdjust = this.m.OffhandWeight
				});
			}
		}
	}

	// Apply hit chance penalty to attack skills
	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (!_skill.m.IsAttack) {
			return;
		}
		if (this.m.ExcludedSkills.find(_skill.getID()) != null) {
			return;
		}
		_properties.MeleeSkill -= this.m.OffhandWeight;
		_skill.m.HitChanceBonus -= this.m.OffhandWeight;
	}

	function onAnySkillExecuted(_skill, _targetTile, _targetEntity, _forFree) {

		// Only trigger for attacks
		if (!_skill.m.IsAttack) {
			return;
		}

		// Don't trigger for Double Swing or follow ups (prevents infinite loop)
		if (this.m.ExcludedSkills.find(_skill.getID()) != null || this.m.IsExecutingOffhand) {
			return;
		}

		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);

		// Check target is valid
		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying()) {
			return;
		}

		// Check distance
		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > 1) {
			return;
		}

		// Determine if the attack came from the offhand
		local isOffhandAttack = _skill.m.Item != null
			&& off != null
			&& _skill.m.Item.getInstanceID() == off.getInstanceID();

		local skillToUse = null;
		if (isOffhandAttack) {
			// Offhand attack, follow up with mainhand
			if (mh != null && ::MSU.isNull(this.m.MainHandSkill)) {
				local skill = ::Legends.Weapons.findPrimaryAttackSkill(actor, mh);
				if (skill != null) {
					this.m.MainHandSkill = ::MSU.asWeakTableRef(skill);
				}
			}
			if (!items.hasBlockedSlot(::Const.ItemSlot.Mainhand)
				&& !::MSU.isNull(this.m.MainHandSkill))
			{
				skillToUse = this.m.MainHandSkill;
			}
		} else {
			// Mainhand attack, follow up with offhand
			if (off != null && ::MSU.isNull(this.m.OffHandSkill)) {
				local skill = ::Legends.Weapons.findPrimaryAttackSkill(actor, off);
				if (skill != null) {
					this.m.OffHandSkill = ::MSU.asWeakTableRef(skill);
				}
			}
			if (!items.hasBlockedSlot(::Const.ItemSlot.Offhand)
				&& !::MSU.isNull(this.m.OffHandSkill))
			{
				skillToUse = this.m.OffHandSkill;
			}
		}

		// Schedule follow-up attack
		if (!_forFree && skillToUse != null) {
			this.Const.SkillCounter++;
			::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.executeFollowUpAttack.bindenv(this), {
				TargetTile = _targetTile,
				Skill = skillToUse
			});
		}
	}

	function executeFollowUpAttack(_info) {
		local entity = _info.TargetTile.getEntity();
		if (::Legends.S.isEntityNullOrDead(entity)) {
			return;
		}
		if (::MSU.isNull(_info.Skill)) {
			return;
		}
		_info.Skill.m.IsExecutingOffhand = true;
		_info.Skill.useForFree(_info.TargetTile);
		this.m.IsExecutingOffhand = false;
	}

	function onEquip(_item) {
		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (mh != null && mh.getInstanceID() == _item.getInstanceID()) {
			local skill = ::Legends.Weapons.findPrimaryAttackSkill(actor, _item);
			if (skill != null) {
				this.m.MainHandSkill = ::MSU.asWeakTableRef(skill);
			}
		}

		if (oh != null && oh.getInstanceID() == _item.getInstanceID()) {
			local skill = ::Legends.Weapons.findPrimaryAttackSkill(actor, _item);
			if (skill != null) {
				this.m.OffHandSkill = ::MSU.asWeakTableRef(skill);
				this.m.OffhandWeight = getOffhandWeight(actor, oh);
			}
		}

		if (!this.m.IsRefreshing) {
			if (mh != null && oh != null && mh.getID() != oh.getID()) {
				if (mh == _item) {
					this.m.NeedsRefresh = "oh";
				} else if (oh == _item) {
					this.m.NeedsRefresh = "mh";
				}
			}
		}
	}

	function onUnequip(_item) {
		this.m.MainHandSkill = null;
		this.m.OffHandSkill = null;

		// Mark which slot needs refresh
		if (!this.m.IsRefreshing) {
			local items = this.getContainer().getActor().getItems();
			local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (mh != null && oh != null && mh.getID() != oh.getID()) {
				if (mh == _item) {
					this.m.NeedsRefresh = "oh";
				} else if (oh == _item) {
					this.m.NeedsRefresh = "mh";
				}
			} else if (mh != null && mh != _item && oh == null) {
				this.m.NeedsRefresh = "mh";
			} else if (oh != null && oh != _item && mh == null) {
				this.m.NeedsRefresh = "oh";
			}
		}
	}

	function onAfterUpdate(_properties) {
		if (this.m.NeedsRefresh == null || this.m.IsRefreshing) {
			return;
		}

		local refreshTarget = this.m.NeedsRefresh;
		this.m.NeedsRefresh = null;
		this.m.IsRefreshing = true;

		local actor = this.getContainer().getActor();
		local items = actor.getItems();

		if (refreshTarget == "mh") {
			local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (mh != null) {
				mh.onUnequip();
				mh.onEquip();
			}
		} else if (refreshTarget == "oh") {
			local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			if (oh != null) {
				oh.onUnequip();
				oh.onEquip();
			}
		}

		this.m.IsRefreshing = false;
	}

});
