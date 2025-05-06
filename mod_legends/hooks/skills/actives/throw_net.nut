::mods_hookExactClass("skills/actives/throw_net", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		m.Description = "Throw a net on your target in order to prevent them from moving or defending themself effectively.";
		m.IsRanged = true;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Some targets can never be caught or ensnared"
		});

		return tooltip;
	}

	o.onAfterUpdate = function ( _properties )
	{
		m.IsHidden = !::MSU.isNull(getItem()) && getItem().isItemType(::Const.Items.ItemType.Net) && getItem().m.Ammo <= 0;

		if (_properties.IsSpecializedInNets) {
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}

		if (_properties.IsSpecializedInNetCasting)
			this.m.MaxRange = 5;
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local isPlayer = ::MSU.isKindOf(_user, "player");
		local net = _user.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		local target = _targetTile.getEntity();

		if (net != null && target != null && !target.getCurrentProperties().IsImmuneToRoot && isPlayer) { //prevent player from looting enemy nets
			target.getFlags().set("DropNet", true);
			target.getFlags().set("IsByNetCasting", false);
			target.getFlags().set("IsReinforcedNet", false);

			if(_user.getCurrentProperties().IsSpecializedInNetCasting) //Net casting flag
			{ 
				target.getFlags().set("IsByNetCasting", true);
			}
			if (net.getID().find("reinforced_throwing_net") != null) //Reinforced net flag
			{ 
				target.getFlags().set("IsReinforcedNet", true);
			}	
		}
		return onUse(_user, _targetTile);
	}
});
