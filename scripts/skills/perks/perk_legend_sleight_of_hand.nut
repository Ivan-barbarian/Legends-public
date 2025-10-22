this.perk_legend_sleight_of_hand <- this.inherit("scripts/skills/skill", {
	m = {},	
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSleightOfHand);
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onNewRound()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.Weapon) || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing) || weapon.getAmmoMax() == 0)
			return;
		if (weapon.getAmmoMax() != weapon.getAmmo())
		{
			weapon.setAmmo(::Math.min(weapon.getAmmoMax(), weapon.getAmmo() + 1));
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " gains one extra ammo for " + weapon.getName() + ".");
			return;
		}
	} 
});
