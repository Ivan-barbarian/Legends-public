this.legend_legion_slave_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_slave";
		this.m.Name = "Servus";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "Taken from a distant land lost to time, this slave still fights for their household.";
		this.m.GoodEnding = ""; 
		this.m.BadEnding = ""; 
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [ //can roll; brute, clubfooted, clumsy, fragile, huge, hesitant, strong, sure footing, survivor, tiny, tough, bright, lucky, shortsighted, aggressive, martial, predictable, lumbering, quick, swift, team player, hate nobles, frail, etc (see commented out below)
			::Legends.Traits.getID(::Legends.Trait.Ailing), //only including naturally occouring or obtainable traits.
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			// ::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			// ::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			// ::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			// ::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.EagleEyes),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			// ::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			// ::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			// ::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			// ::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.NightOwl),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			//legend traits
			// ::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			// ::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			// ::Legends.Traits.getID(::Legends.Trait.LegendFrail),
			//::Legends.Traits.getID(::Legends.Trait.LegendCannibalistic),
			// ::Legends.Traits.getID(::Legends.Trait.LegendSteadyHands),
			// ::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			// ::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			// ::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			// ::Legends.Traits.getID(::Legends.Trait.LegendTalented),
		];

		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery
		];

		//apperance
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		//---
		this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		this.m.Names = this.Const.Strings.AncientDeadNames;
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		// this.m.Level = this.Math.rand(2, 4);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[4]; // 5, 8, 13, 21, 34, 55
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.05, //plains
				0.01, //swamp
				0.02, //hills
				0.03, //forest
				0.03, //forest
				0.03, //forest_leaves
				0.03, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.05, //farmland
				0.02, //snow
				0.02, //badlands
				0.02, //highlands
				0.02, //stepps
				0.0, //ocean
				0.05, //desert
				0.05 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BeastClassTree,
				this.Const.Perks.SlingClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.Names = this.Const.Strings.AncientDeadNamesFemale;
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription() //—
	{
		return "{%slave% hunches and hobbles along as though their bone frame was still burdened by calloused flesh and aching muscles. | %slave% appears oblivious to their undeath, limping and lamenting their station, ever fearful of their superiors overhearing and adding to their misfortunes. | Wearing the scars of decades of servitude at the bottom of the Legion, %slave%\'s bony frame threatens to crumble under the weight of more orders. | March. Dig. Cook. Build. March. Kill. March. The endless labours of %slave% persist even in the face of their undeath. | With a bony frame that portrays weakness and years of backbreaking work even after death, %slave% shuffles with a stiffness that betrays their battered state.} {A slave in the Legion, their station affords them an excessive regime of endless work. Digging trenches, stripping corpses, and making said corpses dominate the daily unlife of this walking cadaver. | Filling the disposable ranks of the Legion\'s many slaves, their work is dominated with manual and violent tasks to ensure the unimpeded task of the machine-like Legion. | As one of many faceless slaves within the Legion, they fill the role of the disposable body to throw at problems — fighting, carrying of supplies, and their eventual destruction are vital parts of their role. | Providing comforts to the rest of the Legion at the expense of their own, the work of a Legion slave is one of never-ending toil and torment. | The often unseen labour behind the Legion\'s frightening efficiency, the labouring slave shares no glory and wins no accolades for its success, but is first to suffer setbacks both on and off the battlefield.} {If %slave%'s face had any flesh or human features left, it would betray unspeakable sadness and desperation in the face of their endless torment. Instead, a cold and hollow skull hides such inconveniences, only presenting as ready for more orders. | Despite their station, %slave% wears a misplaced enthusiasm to serve and better their situation, tricked by their own delusion that eventually, their toils will end, and they will rise through the Legion as a respected figure. | Fearing the ever-present judgement of their betters, %slave% toils with a fervour that threatens to break apart their fragile frame. | The resignation to their fate is clear in how %slave% carries themself. Aware of their nature within the Legion\'s endless campaign, they seemingly await their destruction to return them to the earth, were they so lucky. | Having spent little time in their station, the almost eager demeanour of %slave% is likely to be short lived. With the weight of the Legion\'s endless orders upon their hollow shoulders, one must wonder how long they\'ll last before crumbling into dust...}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				-3,
				7
			],
			Bravery = [ //not needed except for resisting charm and sleep
				0,
				0
			],
			Stamina = [ //not needed except for equipment weight
				0,
				5
			],
			MeleeSkill = [
				-2,
				1
			],
			RangedSkill = [
				4,
				8
			],
			MeleeDefense = [
				-1,
				2
			],
			RangedDefense = [
				0,
				2
			],
			Initiative = [
				-4,
				3
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = [ //all injuries associated with stamina regen, health or resolve
		//perma injuries must be managed in actor.nut, NOT here!
		//	"injury.traumatized",
		//	"injury.brain_damage",
		//	"injury.missing_nose",
		//	"injury.weakened_heart",
		//	"injury.collapsed_lung_part",
		//temp
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.deep_abdominal_cut",
			"injury.deep_chest_cut",
			"injury.exposed_ribs",
			"injury.grazed_kidney",
			"injury.grazed_neck",
			"injury.infected_wound",
			"injury.sickness",
			"injury.stabbed_guts",
			"injury.broken_nose",
			"injury.crushed_windpipe",
			"injury.fractured_ribs",
			"injury.inhaled_flames",
			"injury.pierced_chest",
			"injury.pierced_lung",
			"injury.pierced_side",
			"injury.pierced_cheek"
		];
		this.getContainer().getActor().getFlags().add("legion_can_command");  //justfies if this background is subject to the Legion command skill
	}

	function adjustHiringCostBasedOnEquipment() //reduces cost for equipment worn on skeletons to zero for recruiting purposes.
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/ancient/falx"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_dilapitated_sling"));
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[2, ::Legends.Armor.Standard.leather_wraps],
			[3, ::Legends.Armor.Standard.indebted_armor_rags],
			[2, ::Legends.Armor.Ancient.ancient_ripped_cloth],
			[3, ::Legends.Armor.None]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_household_helmet],
			[2, ::Legends.Helmet.None]
		]));
	}
});
