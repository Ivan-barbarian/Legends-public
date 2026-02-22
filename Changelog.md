# 19.3.0 - Title Pending

## Dual Wielding

Any one-handed weapon can be equipped in the offhand slot when the mainhand already holds a one-handed weapon.

This activates Dual Wield:

- Automatically triggers a free **follow-up offhand attack** after every mainhand attack
- Applies a **fatigue and hit chance penalty** based on the offhand weapon's weight
- Grants the **Double Swing** active skill (an AoE attack hitting up to 3 adjacent tiles, using both weapons)

## Traits
- Hesitant now acts last in turn order
- Impatient acts first in turn order but cannot wait and loses 10% of melee defense
> Both of the above can still be manipulated by effects like adrenaline, the exact math is that Adrenaline increases turn order number by 2000, Hesitant and Impatient subtract/add 1000 respectively
> A character with Adrenaline and Hesitant will act before every other character but will act after a character with Adrenaline who does not have Hesitant
> A character with Impatient will act before everyone else but will act after a character with Adrenaline unless they also have Adrenaline, in which case they will always be first
- Greedy will now increase wage by 25% but also gain 1 to every attribute for every 10 gold paid in wages
- Eagle Eyes now increases vision by 2

## Favoured enemy rework

Perks were condensed into a few:
Favoured Enemy - Beasts
Favoured Enemy - Occult
Favoured Enemy - Greenskin
Favoured Enemy - Undead
Favoured Enemy - Civilization
Favoured Enemy - Outlaw
Favoured Enemy - Sword Master

## New enemies

- Orc Tyrant - elite orc warlord, his warcry can cascade on other warlords
- Orc Mad Berserker - elite version of the orc berserker, has nimble and nudist
- Wicht - armored ghost enemies who cannot be killed until you destroy their armor

## Enemy Changes

- Bandit Warlord is renamed to Robber Baron

## New Runes

- Weapon Fire rune - sets tile on fire on hit
- Helmet Patience rune - initiative bonus, hit chance on wait
- Shield Durability rune - additional durability to shields, a chance to ignore shield damage

## Integrated mods

- Integrated Better Obituary v3, thanks to Allania
- layer logger from Merc - check mod options under misc

## Perk Changes

- **Sword Mastery**: Riposte can trigger from both weapons when dual wielding swords
- **Axe Mastery**: Split Shield uses combined shield damage from both weapons when dual wielding axes
- **Flail Mastery**: Both attacks apply Bleed when dual wielding flails
- **Dagger Mastery**: Offhand successful hits grant -1 AP and +10% damage on next mainhand attack when dual wielding daggers
- **Ambidextrous**: Now also reduces weight penalty by 33% when dual wielding other weapons

## Item Changes

### Helmets
- merged the two fencer hats
	
### Weapons

#### New Weapon Abilities

**Throwing**
- `Throw Backup Spear` - each one handed spear has 1 stack of a throwable ability
- `Throw Backup Axe` - each one handed axe has 1 stack of a throwable ability
- `Throw Backup Daggers` - each puncture dagger (daggers that don't have deathblow innately) has 8 stacks of a throwable ability
> attacks twice if you have a free offhand, 4 ap cost, 12 fatigue, 3 maximum range
> headshots will apply Distracted

**Warbrand and Rhompaias**
- `Breach` - `Slash`
> will deal an additional 15% damage vs enemies armed with polearms and melee weapons with range
- `Swing` - unchanged
- `Split` - unchanged
- `Into The Fray` - 2 tile charge and attack with `Breach`

**One Handed Straight Swords**
* Ancient sword, Arming Sword, Gladius, Short Sword, Named Sword, Noble Sword
* `Slash` - unchanged
* `Riposte` - unchanged
* `Halfsword` - puncture
> 5 ap cost and requires double grip to be usable
* `Mordhau` - batter (hammer)
> 5 ap cost, doubles your armor damage with this skill and always deals at least 10 hp

**Falchions**
- `Breach` - `Slash`
> will deal an additional 15% damage vs enemies armed with polearms and melee weapons with range
- `Gash` - unchanged
- `Riposte` - unchanged

**2h Axes**
* `Split Man` - unchanged
* `Round Swing` - unchanged
* `Split Shield` - unchanged
* `Haftstrike` - a weak but quick attack with the haft 
> costs 4 ap and 15 fatigue, the ap cost reduces by 1 with each successful attack this turn by **other** skills 

**2h Hammers**
* `Smite` - unchanged
* `Shatter` - unchanged
* `Split Shield` - unchanged
* `Obliterate` - exceptionally strong slow hammer attack - added to 2h hammer
> 6 ap, 30 fatigue, 150% damage and 33% lower threshold to inflict injury
> -75% chance to hit increased, +25% from mastery and +50% against targets being rooted
> staggers on hit and hitting already staggered enemies will stun them

**Handgonnes**
* `Fire Handgonne` - unchanged
* `Reload`
* `Line Them Up`
> 3 (4 with mastery) tile shot in a straight line, does 25% more damage

### For modders:

- `Knifeplay` perk has been deleted

- merged the two fencer hats

### New recipes

- new silk blueprint
- 3 new gold ingot blueprints
- 3 new silver ingot blueprints

### For modders:

Bandit Warlord renamed to Robber Baron
```
LegendBanditWarlord.nut -> LegendRobberBaron.nut
this.Const.EntityType.LegendBanditWarlord -> this.Const.EntityType.LegendRobberBaron
```

Following trees were removed, refer to `z_perks_tree_enemy.nut` for replacements:

```
::Const.Perks.GhoulTree
::Const.Perks.DirewolfTree
::Const.Perks.SpiderTree
::Const.Perks.LindwurmTree
::Const.Perks.SchratTree
::Const.Perks.HexenTree
::Const.Perks.AlpTree
::Const.Perks.SkeletonTree
::Const.Perks.ZombieTree
::Const.Perks.VampireTree
::Const.Perks.OrcsTree
::Const.Perks.OrcTree
::Const.Perks.GoblinTree
::Const.Perks.UnholdTree
::Const.Perks.CaravanTree
::Const.Perks.MercenaryTree
::Const.Perks.NoblesTree
::Const.Perks.OutlandersTree
::Const.Perks.BanditTree
::Const.Perks.BarbarianTree
::Const.Perks.ArchersTree
::Const.Perks.ArcherTree
::Const.Perks.SouthernersTree
::Const.Perks.NomadsTree
::Const.Perks.MysticTree
```
