this.legend_skill_book <- ::inherit("scripts/items/item", {
	m = {
		Selection = null,
		PerkGroups = [],
		PerkGroupSelection = null,
		HasToBeIdentified = false,
		Cooldown = 50, // default for skillbooks
		BookName = ""
	},
	function create()
	{
		this.item.create();
		this.m.ID = "";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUsable = true;
		this.m.Value = 0;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = getName()
			},
			{
				id = 2,
				type = "description",
				text = getDescription()
			},
			{
				id = 66,
				type = "text",
				text = getValueString()
			},
			{
				id = 3,
				type = "image",
				image = getIcon()
			},
			{
				id = 65,
				type = "text",
				text = "Right-click to use on a character. Studying will lead to irritability. What mercenary wants to study?"
			},
			{
				id = 67,
				type = "text",
				text = "Will apply a" + this.m.Cooldown + " day cooldown until you can read again."
			}
		];
		if (this.m.HasToBeIdentified && ::World.Statistics.getFlags().get("HasScholar") || !this.m.HasToBeIdentified)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = format("Reading this will allow the user to learn [color=%s]%s[/color] perk group.", ::Const.UI.Color.NegativeValue, this.m.PerkGroupSelection),
			});
		}
		else
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Reading this will allow the user to learn a perk group, but the company does not have a Scholar to know which exactly",
			});
		}
		return result;
	}

	function getName()
	{	
		if (this.m.HasToBeIdentified && ::World.Statistics.getFlags().get("HasScholar") || !this.m.HasToBeIdentified)
			return this.m.BookName + " " + this.m.PerkGroupSelection;
		else
			return this.m.BookName + " " + "Unidentified";
	}

	function isAbleToUseScroll( _actor )
	{
		local effect = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendIrritable);
		if (effect != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=" + ::Const.UI.Color.NegativeValue + "]" + effect.m.HealingTimeMin + "-" + effect.m.HealingTimeMax +"[/color] days.";

		if (_actor.getFlags().getAsInt("LegendsSkillBookCount") <= 1)
			return true;

		return true;
	}

	function onUse( _actor, _item = null )
	{
		local result = isAbleToUseScroll(_actor);
		if (typeof result == "string")
		{
			::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", result);
			return false;
		}

		local tree = null;
		foreach (perkGroup in this.m.PerkGroups)
		{
			if (perkGroup.Name == this.m.PerkGroupSelection)
			{
				tree = perkGroup;
			}
		}

		if (_actor.getBackground().hasPerkGroup(tree)) {
			::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", format("[color=%s]No possible new perk group can be added to this character.[/color].", ::Const.UI.Color.NegativeValue));
			return false;
		}

		_actor.getBackground().addPerkGroup(tree.Tree);

		::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", format("The [color=%s]%s[/color] perk group has been added to this character.", ::Const.UI.Color.NegativeValue, this.m.PerkGroupSelection));
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);

		_actor.getFlags().increment("LegendsScrollCount");

		::Legends.Effects.grant(_actor, ::Legends.Effect.LegendIrritable);
		local effect = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendIrritable);
		if (effect != null)
			effect.addHealingTime(this.m.Cooldown);

		return true;
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeString(this.m.PerkGroupSelection);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.PerkGroupSelection = _in.readString();
	}

});

