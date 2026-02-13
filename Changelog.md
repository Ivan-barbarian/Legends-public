## Dual Wielding

Any one-handed weapon can be equipped in the offhand slot when the mainhand already holds a one-handed weapon.

This activates Dual Wield:

- Automatically triggers a free **follow-up offhand attack** after every mainhand attack
- Applies a **fatigue and hit chance penalty** based on the offhand weapon's weight
- Grants the **Double Swing** active skill (an AoE attack hitting up to 3 adjacent tiles, using both weapons)

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
- layer logger from Merc

## Perk Changes

- **Sword Mastery**: Riposte can trigger from both weapons when dual wielding swords
- **Axe Mastery**: Split Shield uses combined shield damage from both weapons when dual wielding axes
- **Flail Mastery**: Both attacks apply Bleed when dual wielding flails
- **Dagger Mastery**: Offhand successful hits grant -1 AP and +10% damage on next mainhand attack when dual wielding daggers
- **Ambidextrous**: Now also reduces weight penalty by 33% when dual wielding other weapons

## Item Changes

### Helmets

- merged the two fencer hats

### For modders:

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
