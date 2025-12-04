if (!("Weapons" in ::Legends)) {
   ::Legends.Weapons <- {};
}

::Legends.Weapons.findPrimaryAttackSkill <- function (_actor, _weapon) {
    if (_actor == null || _weapon == null) {
        return null;
    }

    local skills = _actor.getSkills();
    local bestSkill = null;
    local bestAPCost = 9999;

    foreach (skill in skills.m.Skills) {
        if (skill.m.Item != null && skill.m.Item.getID() == _weapon.getID()) {

            // Use same validation code as Attack of Opportunity
            if (!skill.isActive()
                || !skill.isAttack()
                || !skill.isTargeted()
                || skill.isIgnoredAsAOO()
                || skill.isDisabled()
                || !skill.isUsable()
                || skill.getMinRange() > 1
                || skill.isRanged())
            {
                continue;
            }

            local apCost = skill.getActionPointCost();
            if (apCost < bestAPCost) {
                bestSkill = skill;
                bestAPCost = apCost;
            }
        }
    }

    if (bestSkill == null) {
       ::logWarning("findPrimaryAttackSkill: no valid primary attack skill found for weapon: " + _weapon.getID());
    }

    return bestSkill;
}

// Returns true if the skill belongs to the item equipped in the mainhand.
::Legends.Weapons.isMainHandSkill <- function (_actor, _skill) {
    return ::Legends.Weapons.isSlotSkill(_actor, _skill, ::Const.ItemSlot.Mainhand);
}

// Returns true if the skill belongs to the item equipped in the offhand.
::Legends.Weapons.isOffHandSkill <- function (_actor, _skill) {
    return ::Legends.Weapons.isSlotSkill(_actor, _skill, ::Const.ItemSlot.Offhand);
}

// Returns true if the skill belongs to the item equipped in the given slot.
::Legends.Weapons.isSlotSkill <- function (_actor, _skill, _slot) {
    if (_actor == null || _skill == null || _slot == null) {
        return false;
    }
    local items = _actor.getItems();
    local item = items.getItemAtSlot(_slot);
    if (item == null) {
        return false;
    }
    return _skill.m.Item != null && item != null && _skill.m.Item.getID() == item.getID();
}

// Returns true if dual wielding weapons not covered by Ambidextrous.
::Legends.Weapons.isDualWielding <- function (_actor) {
    return _actor != null && _actor.getFlags().get(::Legends.Flags.DualWield) == true;
}
