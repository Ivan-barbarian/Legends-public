this.legend_dual_wield_offhand_effect <- this.inherit("scripts/skills/skill", {
	m = {
		OffhandWeapon = null,
		OffhandDamageMult = 0.5
	},

	function setOffhandWeapon(_weapon) {
		this.m.OffhandWeapon = ::MSU.asWeakTableRef(_weapon);
	}

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDualWieldOffhand);
		this.m.Description = "This character is dual wielding weapons. Attacks with the offhand weapon deal reduced damage.";
		this.m.Icon = "ui/perks/ambidexterity_circle.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsHidden = false;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]-" + this.Math.floor(this.m.OffhandDamageMult * 100) + "%[/color] damage with offhand weapon"
			}
		];
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill.m.Item != null && !::MSU.isNull(this.m.OffhandWeapon)) {
			::logDebug("legend_dual_wield_offhand_effect: Skill: " + _skill.m.Item.getID() + " | Offhand: " + this.m.OffhandWeapon.getID());
			if (_skill.m.Item.getID() == this.m.OffhandWeapon.getID()) {
				local _originalDamageMult = _properties.DamageTotalMult;
				_properties.DamageTotalMult *= this.m.OffhandDamageMult;
				::logDebug("legend_dual_wield_offhand_effect: Old mult: " + _originalDamageMult + " | New mult: " + _properties.DamageTotalMult);
			} else {
				::logDebug("legend_dual_wield_offhand_effect: Skill item does not match offhand weapon");
			}
		} else {
			::logDebug("legend_dual_wield_offhand_effect: Skill has no item or offhand weapon not set");
		}
	}
});
