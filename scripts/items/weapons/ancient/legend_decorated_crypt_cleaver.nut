this.legend_decorated_crypt_cleaver <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_decorated_crypt_cleaver";
		this.m.Name = "Decorated Crypt Cleaver";
		this.m.Description = "A light, ceremonial version of a two-handed cleaver with a curved end, adorned with gold inlay and odd motifs.";
		this.m.IconLarge = "weapons/melee/cryptcleaver_01_1.png";
		this.m.Icon = "weapons/melee/cryptcleaver_01_1_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_cryptcleaver_01_1";
		this.m.Value = 2500;
		this.m.ShieldDamage = 12;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.StaminaModifier = -13;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.15;
		this.m.Bravery = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Cleave, function (_skill) {
			_skill.m.FatigueCost = 10;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate);
		// ::Legends.Actives.grant(this, ::Legends.Active.Swing);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield);
	}
});