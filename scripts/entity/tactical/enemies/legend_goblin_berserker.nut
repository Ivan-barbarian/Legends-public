this.legend_goblin_berserker <- this.inherit("scripts/entity/tactical/enemies/goblin_fighter", {
	m = {},

	function create()
	{
		this.m.Type = ::Const.EntityType.LegendGoblinBerserker;
		this.m.XP = ::Const.Tactical.Actor.LegendGoblinBerserker.XP;
		this.goblin.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/goblin_wolfrider_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin_fighter.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendGoblinBerserker);
		::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendUberNimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendVengeance);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 4);
		if (r <= 1)
		{
			this.m.Items.equip(::new("scripts/items/weapons/greenskins/goblin_pike"));
		}
		else if (r <= 2)
		{
			this.m.Items.equip(::new("scripts/items/weapons/greenskins/legend_goblin_infantry_axe"));
		}
		else
		{
			this.m.Items.equip(::new("scripts/items/weapons/warbrand"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/legend_named_goblin_axe_2h",
			"weapons/named/named_goblin_pike",
			"weapons/named/named_warbrand"
		];
		this.m.Items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		::Legends.Perks.grant(this, ::Legends.Perk.Steadfast);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		return true;
	}

});
