this.legend_dual_wield_effect <- this.inherit("scripts/skills/skill", {
	m = {
		OffhandWeight = 0,
		OffHandSkill = null,
		AmbidextrousBonus = 0.33,
		IsRefreshing = false,
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

		// Find and store the offhand attack skill
		local oh = actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
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

		// Don't trigger for Double Swing (prevents infinite loop)
		if (this.m.ExcludedSkills.find(_skill.getID()) != null) {
			return;
		}

		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);

		// Don't trigger if the attack came from the offhand
		if (_skill.m.Item != null
			&& off != null
			&& _skill.m.Item.getInstanceID() == off.getInstanceID())
		{
			return;
		}

		// Check target is valid
		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying()) {
			return;
		}

		// Check distance
		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) > 1) {
			return;
		}

		// Refresh offhand skill reference if it became invalid
		if (off != null && ::MSU.isNull(this.m.OffHandSkill)) {
			local skill = ::Legends.Weapons.findPrimaryAttackSkill(actor, off);
			if (skill != null) {
				this.m.OffHandSkill = ::MSU.asWeakTableRef(skill);
			}
		}

		// Schedule follow-up attack
		if (!_forFree
			&& !items.hasBlockedSlot(::Const.ItemSlot.Offhand)
			&& !::MSU.isNull(this.m.OffHandSkill))
		{
			local skillToUse = this.m.OffHandSkill;

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
	}

	function onEquip(_item) {
		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

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
