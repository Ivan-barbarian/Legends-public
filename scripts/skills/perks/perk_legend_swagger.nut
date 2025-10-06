this.perk_legend_swagger <- this.inherit("scripts/skills/skill", {
	m = {
		ArmorAdded = 0,
		HelmetAdded = 0
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSwagger);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip ()
	{
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
				icon = "ui/icons/armor_body.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getBonus(::Const.ItemSlot.Body) + "[/color] armor condition added at start of combat"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(this.getBonus(this.Const.ItemSlot.Head) / 2) + "[/color] helmet condition added at start of combat"
			}
		];
	}

	function onCombatStarted ()
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		this.m.ArmorAdded = this.getBonus(this.Const.ItemSlot.Body);
		this.m.HelmetAdded = this.Math.floor(this.getBonus(this.Const.ItemSlot.Head) / 2);
		properties.Armor[this.Const.BodyPart.Body] += this.m.ArmorAdded;
		properties.Armor[this.Const.BodyPart.Head] += this.m.HelmetAdded;
		properties.ArmorMax[this.Const.BodyPart.Body] += this.m.ArmorAdded;
		properties.ArmorMax[this.Const.BodyPart.Head] += this.m.HelmetAdded;
	}

	function onCombatFinished ()
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		properties.Armor[this.Const.BodyPart.Body] -= this.m.ArmorAdded;
		properties.Armor[this.Const.BodyPart.Head] -= this.m.HelmetAdded;
		properties.ArmorMax[this.Const.BodyPart.Body] -= this.m.ArmorAdded;
		properties.ArmorMax[this.Const.BodyPart.Head] -= this.m.HelmetAdded;
	}

	function getBonus (_slot)
	{
		local actor = this.getContainer().getActor();
		local slot = actor.getItems().getItemAtSlot(_slot);
		local slotValue = 0;
		local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local bodyvalue = 0;
		local headvalue = 0;

		if (slot != null)
			bodyvalue = bodyvalue + body.getValue();

		if (head != null)
			headvalue = headvalue + head.getValue();

		local fat = actor.getItems().getStaminaModifier([
				::Const.ItemSlot.Body,
				::Const.ItemSlot.Head,
		]);

		local gearvalue = bodyvalue + headvalue;
		return gearvalue * 0.002 * (1.0 + 0.01 * fat); //
	}
});
