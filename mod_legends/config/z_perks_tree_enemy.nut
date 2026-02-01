if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

local category = "Enemy";

::Const.Perks.BeastsTree <- {
	ID = "BeastsTree",
	Name = "Beasts",
	Icon = "ui/perks/favoured_direwolf_01.png",
	Category = category,
	Descriptions = [
		"beasts"
	],
	
	Tree = [
		[],
		[],
		[],
		[
			::Legends.Perk.LegendFavouredEnemyGhoul,
			::Legends.Perk.LegendFavouredEnemyDirewolf,
			::Legends.Perk.LegendFavouredEnemySpider
		],
		[],
		[::Legends.Perk.LegendFavouredEnemyLindwurm],
		[]
	]
};

::Const.Perks.GhoulTree <- {
	ID = "GhoulTree",
	Name = "Nachzehrers",
	Icon = "ui/perks/favoured_ghoul_01.png",
	Descriptions = [
		"nachzehrers"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyGhoul],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.DirewolfTree <- {
	ID = "DirewolfTree",
	Name = "Direwolves",
	Icon = "ui/perks/favoured_direwolf_01.png",
	Descriptions = [
		"direwolves"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyDirewolf],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.SpiderTree <- {
	ID = "SpiderTree",
	Name = "Webknechts",
	Icon = "ui/perks/favoured_spider_01.png",
	Descriptions = [
		"spiders"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySpider],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.LindwurmTree <- {
	ID = "LindwurmTree",
	Name = "Lindwurms",
	Icon = "ui/perks/favoured_lindwurm_01.png",
	Category = category,
	Descriptions = [
		"lindwurms"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyLindwurm],
		[]
	]
};

::Const.Perks.MysticTree <- {
	ID = "MysticTree",
	Descriptions = [
		"mystics"
	],
	Name = "Mystics",
	Icon = "ui/perks/favoured_hexen_01.png",
	Category = category,
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySchrat],
		[
		::Legends.Perk.LegendFavouredEnemyHexen,
		::Legends.Perk.LegendFavouredEnemyAlps
		]
	]
};

::Const.Perks.SchratTree <- {
	ID = "SchratTree",
	Name = "Schrats",
	Icon = "ui/perks/favoured_schrat_01.png",
	Descriptions = [
		"schrats"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySchrat],
		[]
	]
};

::Const.Perks.HexenTree <- {
	ID = "HexenTree",
	Name = "Hexen",
	Icon = "ui/perks/favoured_hexen_01.png",
	Descriptions = [
		"hexen"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyHexen]
	]
};

::Const.Perks.AlpTree <- {
	ID = "AlpTree",
	Name = "Alps",
	Icon = "ui/perks/favoured_alps_01.png",
	Descriptions = [
		"alps"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyAlps]
	]
};

::Const.Perks.UndeadTree <- {
	ID = "UndeadTree",
	Name = "Undead",
	Icon = "ui/perks/favoured_zombie_01.png",
	Category = category,
	Descriptions = [
		"undead"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		::Legends.Perk.LegendFavouredEnemySkeleton,
		::Legends.Perk.LegendFavouredEnemyZombie
		],
		[],
		[::Legends.Perk.LegendFavouredEnemyVampire]
	]
};

::Const.Perks.SkeletonTree <- {
	ID = "SkeletonTree",
	Name = "Ancient Empire",
	Icon = "ui/perks/favoured_skeleton_01.png",
	Descriptions = [
		"ancient empire"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySkeleton],
		[],
		[]
	]
};

::Const.Perks.ZombieTree <- {
	ID = "ZombieTree",
	Name = "Wiedergangers",
	Icon = "ui/perks/favoured_zombie_01.png",
	Descriptions = [
		"wiedergangers"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyZombie],
		[],
		[]
	]
};

::Const.Perks.VampireTree <- {
	ID = "VampireTree",
	Name = "Necrosavants",
	Icon = "ui/perks/favoured_vampire_01.png",
	Descriptions = [
		"necrosavants"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyVampire]
	]
};

::Const.Perks.OrcsTree <- {
	ID = "OrcsTree",
	Name = "Greenskins",
	Icon = "ui/perks/favoured_ork_01.png",
	Category = category,
	Descriptions = [
		"greenskins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		::Legends.Perk.LegendFavouredEnemyOrk,
		::Legends.Perk.LegendFavouredEnemyGoblin
		],
		[::Legends.Perk.LegendFavouredEnemyUnhold],
		[]
	]
};

::Const.Perks.OrcTree <- {
	ID = "OrcTree",
	Name = "Orcs",
	Icon = "ui/perks/favoured_ork_01.png",
	Descriptions = [
		"orcs"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyOrk],
		[],
		[]
	]
};

::Const.Perks.GoblinTree <- {
	ID = "GoblinTree",
	Name = "Goblins",
	Icon = "ui/perks/favoured_goblin_01.png",
	Descriptions = [
		"goblins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyGoblin],
		[],
		[]
	]
};

::Const.Perks.UnholdTree <- {
	ID = "UnholdTree",
	Name = "Unholds",
	Icon = "ui/perks/favoured_unhold_01.png",
	Descriptions = [
		"unholds"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyUnhold],
		[]
	]
};

::Const.Perks.CivilizationTree <- {
	ID = "CivilizationTree",
	Name = "Civilians",
	Icon = "ui/perks/favoured_caravan_01.png",
	Category = category,
	Descriptions = [
		"civilians"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyCaravan],
		[],
		[::Legends.Perk.LegendFavouredEnemyMercenary],
		[::Legends.Perk.LegendFavouredEnemyNoble,
		 ::Legends.Perk.LegendFavouredEnemySoutherner
		],
		[]
	]
};

::Const.Perks.CaravanTree <- {
	ID = "CaravanTree",
	Name = "Caravans",
	Icon = "ui/perks/favoured_caravan_01.png",
	Descriptions = [
		"caravans"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyCaravan],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.MercenaryTree <- {
	ID = "MercenaryTree",
	Name = "Mercenaries",
	Icon = "ui/perks/favoured_mercenary_01.png",
	Descriptions = [
		"mercenaries"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyMercenary],
		[],
		[]
	]
};

::Const.Perks.NoblesTree <- {
	ID = "NoblesTree",
	Name = "Nobles",
	Icon = "ui/perks/favoured_noble_01.png",
	Descriptions = [
		"nobles"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyNoble],
		[]
	]
};

::Const.Perks.OutlandersTree <- {
	ID = "OutlandersTree",
	Name = "Outlanders",
	Icon = "ui/perks/favoured_bandit_01.png",
	Category = category,
	Descriptions = [
		"outlanders"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		 ::Legends.Perk.LegendFavouredEnemyBandit,
		 ::Legends.Perk.LegendFavouredEnemyNomad
		 ],
		[::Legends.Perk.LegendFavouredEnemyBarbarian],
		[]
	]
};

::Const.Perks.BanditTree <- {
	ID = "BanditTree",
	Name = "Bandits",
	Icon = "ui/perks/favoured_bandit_01.png",
	Descriptions = [
		"bandits"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyBandit],
		[],
		[]
	]
};

::Const.Perks.BarbarianTree <- {
	ID = "BarbarianTree",
	Name = "Barbarians",
	Icon = "ui/perks/favoured_barbarian_01.png",
	Descriptions = [
		"barbarians"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyBarbarian],
		[]
	]
};

::Const.Perks.ArchersTree <- {
	ID = "ArchersTree",
	Name = "Sharpshooters",
	Icon = "ui/perks/favoured_archer_01.png",
	Category = category,
	Descriptions = [
		"sharpshooter"
	],
	Tree = [
		[::Legends.Perk.Pathfinder],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyArcher],
		[]
	]
};

::Const.Perks.ArcherTree <- {
	ID = "ArcherTree",
	Name = "Archers",
	Icon = "ui/perks/favoured_archer_01.png",
	Descriptions = [
		"archers"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyArcher],
		[]
	]
};

::Const.Perks.SwordmastersTree <- {
	ID = "SwordmastersTree",
	Name = "Swordmasters",
	Icon = "ui/perks/favoured_swordmaster_01.png",
	Descriptions = [
		"swordmasters"
	],
	Tree = [
		[],
		[],
		[
			::Legends.Perk.Steadfast,
			::Legends.Perk.LegendSmackdown
		],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySwordmaster],
		[::Legends.Perk.BattleFlow]
	]
};

::Const.Perks.SouthernersTree <- {
	ID = "SouthernersTree",
	Name = "Southerners",
	Icon = "ui/perks/favoured_southerner_01.png",
	Descriptions = [
		"southerners"
	],
	Tree = [
		[],
		[::Legends.Perk.LegendTrueBeliever],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemySoutherner],
		[]
	]
};

::Const.Perks.NomadsTree <- {
	ID = "NomadsTree",
	Name = "Nomads",
	Icon = "ui/perks/favoured_nomad_01.png",
	Category = category,
	Descriptions = [
		"nomads"
	],
	Tree = [
		[::Legends.Perk.Pathfinder],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyNomad],
		[],
		[]
	]
};

::Const.Perks.EnemyTrees <- {
	GroupsCategory = "Enemy",
	Tree = [
		::Const.Perks.GhoulTree,
		::Const.Perks.DirewolfTree,
		::Const.Perks.SpiderTree,
		::Const.Perks.SchratTree,
		::Const.Perks.HexenTree,
		::Const.Perks.AlpTree,
		::Const.Perks.SkeletonTree,
		::Const.Perks.ZombieTree,
		::Const.Perks.VampireTree,
		::Const.Perks.OrcTree,
		::Const.Perks.GoblinTree,
		::Const.Perks.UnholdTree,
		::Const.Perks.CaravanTree,
		::Const.Perks.MercenaryTree,
		::Const.Perks.NoblesTree,
		::Const.Perks.BanditTree,
		::Const.Perks.BarbarianTree,
		::Const.Perks.ArchersTree,
		::Const.Perks.SwordmastersTree,
		::Const.Perks.SouthernersTree
	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}


	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree)
		{
			foreach (p in row)
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}

};
