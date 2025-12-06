if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.BeastTree <- {
	ID = "BeastTree",
	Name = "Beasts",
	Descriptions = [
		"beasts"
	],
	Tree = [
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyBeast],
		[],
		[],
		[],
		[]
	]
};

::Const.Perks.OccultTree <- {
	ID = "OccultTree",
	Name = "Occult",
	Descriptions = [
		"occult"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyOccult],
		[],
		[]
	]
};

::Const.Perks.UndeadTree <- {
	ID = "UndeadTree",
	Name = "Undead",
	Descriptions = [
		"undead"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
		::Legends.Perk.LegendFavouredEnemyUndead
		],
		[],
		[]
	]
};

::Const.Perks.GreenskinTree <- {
	ID = "GreenskinTree",
	Name = "Greenskins",
	Descriptions = [
		"greenskins"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyGreenskin],
		[],
		[]
	]
};

::Const.Perks.CivilizationTree <- {
	ID = "CivilizationTree",
	Name = "Civilization",
	Descriptions = [
		"law-abiding fools"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyCivilization],
		[],
		[]
	]
};

::Const.Perks.OutlawTree <- {
	ID = "OutlawTree",
	Name = "Outlaws",
	Descriptions = [
		"outlaws"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Legends.Perk.LegendFavouredEnemyOutlaw],
		[],
		[]
	]
};

::Const.Perks.SwordmastersTree <- {
	ID = "SwordmastersTree",
	Name = "Swordmasters",
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

::Const.Perks.EnemyTrees <- {
	Tree = [
		::Const.Perks.BeastTree,
		::Const.Perks.OccultTree,
		::Const.Perks.UndeadTree,
		::Const.Perks.GreenskinTree,
		::Const.Perks.CivilizationTree,
		::Const.Perks.OutlawTree,
		::Const.Perks.SwordmastersTree,
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
