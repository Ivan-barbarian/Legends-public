this.perk_legend_keen_eyesight <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeSkillBonus = 0,
		RangedSkillBonus = 0,
		MeleeDefenseBonus = 0,
		RangedDefenseBonus = 0
	},
	
	function setBonus( _vision )
	{
		local helmet = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Head);
		local bonus = 0;
		local mult = 1.0;
		
		this.m.MeleeSkillBonus = 0;
		this.m.RangedSkillBonus = 0;
		this.m.MeleeDefenseBonus = 0;
		this.m.RangedDefenseBonus = 0;
		
		
		if (helmet != null)
		{
			bonus = helmet.getVision() * -1;
			if (bonus > 2)
			{
				mult += -0,1;
			}
			if (bonus > 4)
			{
				mult += -0,1; 
			}
		}
		
		bonus += _vision - 7;
		bonus = ::Math.min(12, bonus);
		
		if (bonus > 0)
		{
			this.m.MeleeSkillBonus = ::Math.floor(bonus * 3 * mult);
			this.m.RangedSkillBonus = ::Math.floor(bonus * 5 * mult);
			this.m.MeleeDefenseBonus = ::Math.floor(bonus * 3 * mult);
			this.m.RangedDefenseBonus = ::Math.floor(bonus * 4 * mult);
		}
	}
	
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendKeenEyesight);
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		this.setBonus(_properties.Vision);
		_properties.MeleeSkill += this.m.MeleeSkillBonus;
		_properties.RangedSkill += this.m.RangedSkillBonus;
		_properties.MeleeDefense += this.m.MeleeDefenseBonus;
		_properties.RangedDefense += this.m.RangedDefenseBonus;
	}
});

