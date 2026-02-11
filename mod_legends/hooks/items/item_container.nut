::mods_hookNewObject("items/item_container", function (o) {
	o.m.Appearance.ArmorLayerChain <- "";
	o.m.Appearance.ArmorLayerPlate <- "";
	o.m.Appearance.ArmorLayerTabbard <- "";
	o.m.Appearance.ArmorLayerCloakFront <- "";
	o.m.Appearance.ArmorLayerCloakBack <- "";
	o.m.Appearance.CorpseArmorLayerChain <- "";
	o.m.Appearance.CorpseArmorLayerPlate <- "";
	o.m.Appearance.CorpseArmorLayerTabbard <- "";
	o.m.Appearance.CorpseArmorLayerCloakFront <- "";
	o.m.Appearance.CorpseArmorLayerCloakBack <- "";
	o.m.Appearance.HelmetLayerVanityLower <- "";
	o.m.Appearance.HelmetLayerVanity2Lower <- "";
	o.m.Appearance.Helmet <- "";
	o.m.Appearance.HelmetLayerHelm <- "";
	o.m.Appearance.HelmetLayerTop <- "";
	o.m.Appearance.HelmetLayerVanity <- "";
	o.m.Appearance.HelmetLayerVanity2 <- "";
	o.m.Appearance.HelmetLayerVanityLowerCorpse <- "";
	o.m.Appearance.HelmetLayerVanity2LowerCorpse <- "";
	o.m.Appearance.HelmetLayerHelmCorpse <- "";
	o.m.Appearance.HelmetLayerTopCorpse <- "";
	o.m.Appearance.HelmetLayerVanityCorpse <- "";
	o.m.Appearance.HelmetLayerVanity2Corpse <- "";

	local addToBag = o.addToBag;
	o.addToBag = function (_item, _slot = -1) {
		return _item == null ? false : addToBag(_item, _slot);
	}

	local isActionAffordable = o.isActionAffordable;
	o.isActionAffordable = function (_items) {
		local ret = isActionAffordable(_items);
		if (!::Legends.Perks.has(this.m.Actor, ::Legends.Perk.LegendNetCasting)) {
			return ret;
		} else if (::Legends.Perks.has(this.m.Actor, ::Legends.Perk.LegendNetCasting)
			&& _items.len() == 1
			&& _items[0].getID().find("throwing_net") != null)
		{
			return true;
		}
		local nets = 0;
		local notNets = 0;
		foreach (item in _items) {
			if (item != null) {
				if (item.getID().find("throwing_net") != null) {
					nets += 1;
				} else {
					notNets += 1;
				}
			}
		}

		// Equipping a net into a free offhand (whether from the bag or from the ground) is always free
		if (_items.len() == 3 && nets == 1 && notNets == 0) {
			return true;
		}
		return ret;
	}

	local getActionCost = o.getActionCost;
	o.getActionCost = function (_items) {
		local ret = getActionCost(_items);
		if (!::Legends.Perks.has(this.m.Actor, ::Legends.Perk.LegendNetCasting)) {
			return ret;
		} else if (::Legends.Perks.has(this.m.Actor, ::Legends.Perk.LegendNetCasting)
			&& _items.len() == 1
			&& _items[0].getID().find("throwing_net") != null)
		{
			return 0;
		}
		local nets = 0;
		local notNets = 0;
		foreach (item in _items) {
			if (item != null) {
				if (item.getID().find("throwing_net") != null) {
					nets += 1;
				} else {
					notNets += 1;
				}
			}
		}

		if (_items.len() == 3 && nets == 1 && notNets == 0) {
			return 0;
		}
		return ret;
	}

	o.drop <- function (item) {
		if (!this.m.Actor.isPlacedOnMap()) {
			return;
		}

		local _tile = this.m.Actor.getTile();
		item.m.IsDroppedAsLoot = true;
		item.drop(_tile);
		_tile.IsContainingItemsFlipped = true;
	}

	local equip = o.equip;
	o.equip = function (_item) {
		if (_item == null) {
			return false;
		}

		// Allow equipping mainhand weapons in offhand slot
		if (_item.getSlotType() == ::Const.ItemSlot.Mainhand
			&& _item.getBlockedSlotType() == null)
		{

			local mh = this.getItemAtSlot(::Const.ItemSlot.Mainhand);
			local oh = this.getItemAtSlot(::Const.ItemSlot.Offhand);
			if (mh != null && oh == null) {

				if (_item.getCurrentSlotType() != ::Const.ItemSlot.None) {
					return false;
				}
				if (!this.canDualWield(this.m.Actor, _item)) {
					return false;
				}

				this.m.Items[::Const.ItemSlot.Offhand][0] = _item;
				_item.setContainer(this);
				_item.setCurrentSlotType(::Const.ItemSlot.Offhand);
				_item.onEquip();
				this.m.Actor.getSkills().update();
				this.updateDualWield();

				return true;
			}
		}

		local result = equip(_item);
		local slot = _item.getSlotType();
		if (result && (slot == ::Const.ItemSlot.Mainhand || slot == ::Const.ItemSlot.Offhand)) {
			this.updateDualWield();
		}

		return result;
	}

	local unequip = o.unequip;
	o.unequip = function (_item) {
		if (_item == null || _item == -1) {
			return;
		}

		// Unequip dual-wielded mainhand weapons in offhand slot
		if (_item.getSlotType() == ::Const.ItemSlot.Mainhand
			&& _item.getCurrentSlotType() == ::Const.ItemSlot.Offhand)
		{
			if (this.getItemAtSlot(::Const.ItemSlot.Offhand) == _item) {
				_item.onUnequip();
				_item.setContainer(null);
				_item.setCurrentSlotType(::Const.ItemSlot.None);
				this.m.Items[::Const.ItemSlot.Offhand][0] = null;

				if (this.m.Actor != null && !this.m.Actor.isNull() && this.m.Actor.isAlive()) {
					this.m.Actor.getSkills().update();
					this.updateDualWield();
				}

				return true;
			}

			return false;
		}

		local result = unequip(_item);
		local slot = _item.getSlotType();
		if (slot == ::Const.ItemSlot.Mainhand || slot == ::Const.ItemSlot.Offhand) {
			this.updateDualWield();
		}

		return result;
	}

	// Incoming nerf to 3-headed flail in 3, 2, 1 ...
	o.canDualWield <- function (_actor, _item) {
		if (_item.isItemType(::Const.Items.ItemType.RangedWeapon)) {
			return false;
		}
		return true;
	}

	o.updateDualWield <- function () {
		local actor = this.m.Actor;
		if (actor == null) {
			return;
		}
		local items = actor.getItems();
		local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		local dw = mh != null
			&& oh != null
			&& mh.isItemType(::Const.Items.ItemType.Weapon)
			&& oh.isItemType(::Const.Items.ItemType.Weapon)
			&& this.canDualWield(actor, mh)
			&& this.canDualWield(actor, oh);
		if (dw) {
			local ambidextrous = ::Legends.Perks.get(actor, ::Legends.Perk.LegendAmbidextrous);
			dw = ambidextrous == null || ambidextrous.m.ApplicableItems.find(oh.getID()) == null;
		}
		if (dw) {
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendDualWield);
			::Legends.Actives.grant(actor, ::Legends.Active.LegendDoubleSwing)
		} else {
			::Legends.Actives.remove(actor, ::Legends.Active.LegendDoubleSwing);
			::Legends.Effects.remove(actor, ::Legends.Effect.LegendDualWield);
		}
	}

	o.unequipNoUpdate <- function (_item) {
		if (_item == null || _item == -1) {
			return;
		}

		if (_item.getCurrentSlotType() == this.Const.ItemSlot.None
			|| _item.getCurrentSlotType() == this.Const.ItemSlot.Bag)
		{
			this.logWarning("Attempted to unequip item " + _item.getName() + ", but is not equipped");
			return false;
		}

		for (local i = 0; i < this.m.Items[_item.getSlotType()].len(); i = ++i) {
			if (this.m.Items[_item.getSlotType()][i] == _item) {
				// _item.onUnequip();
				// _item.setContainer(null);
				// _item.setCurrentSlotType(this.Const.ItemSlot.None);
				this.m.Items[_item.getSlotType()][i] = null;

				if (_item.getBlockedSlotType() != null) {
					for (local i = 0; i < this.m.Items[_item.getBlockedSlotType()].len(); i = ++i) {
						if (this.m.Items[_item.getBlockedSlotType()][i] == -1) {
							this.m.Items[_item.getBlockedSlotType()][i] = null;
							break;
						}
					}
				}
				return true;
			}
		}

		return false;
	}

	o.transferToList <- function (_stash) {
		for (local i = 0; i < this.Const.ItemSlot.COUNT; i = ++i) {
			for (local j = 0; j < this.m.Items[i].len(); j = ++j) {
				if (this.m.Items[i][j] == null || this.m.Items[i][j] == -1) {
					continue
				}

				local item = this.m.Items[i][j];
				if (item.isEquipped()) {
					this.unequip(item);
				} else {
					this.removeFromBag(item);
				}
				_stash.push(item);
				// this.logInfo("Transferred " + item.m.Name + " : " + item.getInstanceID())
				// local res = this.Stash.getItemByInstanceID(item.getInstanceID());
				// if (res == null) {
				//	 this.logInfo("saveFormation::could not find item for " + item.getInstanceID());
				//	 continue
				// }
				//toTransfer.push(item);
			}
		}

		// this.logInfo("TRANSFERED TO STASH COMPLETE. STASH SIZe = " + _stash.m.Items.len())

		// foreach( item in toTransfer )
		// {
		// 	if (_stash.add(item) == null)
		// 	{
		//		 this.logInfo("STASH ADD ITEM IS NULL")
		// 		break;
		// 	}

		// }
	}

	local canDropItems = o.canDropItems;
	o.canDropItems = function (_killer) {
		if (this.m.Actor == null
			|| (this.m.Actor instanceof ::WeakTableRef && this.m.Actor.isNull()))
		{
			return false;
		}
		return canDropItems(_killer);
	}

	// Needed to properly deserialize offhand weapons
	o.onDeserialize = function (_in) {
		this.m.UnlockedBagSlots = _in.readU8();

		local needDualWieldUpdate = false;
		local numItems = _in.readU8();
		for (local i = 0; i < numItems; ++i) {
			local slotType = _in.readU8();
			local item = ::new(::IO.scriptFilenameByHash(_in.readI32()));
			item.onDeserialize(_in);

			local win = false;

			if (slotType == ::Const.ItemSlot.Bag) {
				win = this.addToBag(item);
			} else if (slotType == ::Const.ItemSlot.Offhand
				&& item.getSlotType() == ::Const.ItemSlot.Mainhand
				&& item.getBlockedSlotType() == null)
			{
				// Vanilla just calls `equip(item)` which won't work with offhand weapons
				this.m.Items[::Const.ItemSlot.Offhand][0] = item;
				item.setContainer(this);
				item.setCurrentSlotType(::Const.ItemSlot.Offhand);
				item.onEquip();
				needDualWieldUpdate = true;
				win = true;
			} else {
				win = this.equip(item);
			}

			if (!win) {
				::World.Assets.getOverflowItems().push(item);
			}
		}

		if (needDualWieldUpdate) {
			this.updateDualWield();
		}
	}

});
