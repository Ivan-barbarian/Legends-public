::Legends.addFallen <- function(_bro, _cause) {
	local fallen = {
		Name = _bro.getName(),
		Time = this.World.getTime().Days,
		TimeWithCompany = this.Math.max(1, _bro.getDaysWithCompany()),
		Kills = _bro.getLifetimeStats().Kills,
		Battles = _bro.getLifetimeStats().Battles,
		KilledBy = _cause,
		Expendable = _bro.getBackground().getID() == ::Legends.Backgrounds.IDs.Slave
	};

	::World.Statistics.addFallen(_bro.finalizeFallen(fallen));
}

::Legends.Obituary <- {
	getColoredKeybindText = function(_keybindId) {
		local HexString = ::Legends.Mod.ModSettings.getSetting("obituary_hotkey_text_colour").getValueAsHexString();
		return "[color=#" + HexString.slice(0, 6) + "]" + ::Legends.Mod.Keybinds.getKeybind(_keybindId).getKeyCombinationsCapitalized() + "[/color]";
	},
	Tooltip = {},
	FateText = {}
};

::Legends.Obituary.Tooltip["world-screen.obituary.Level"] <- [
	"Level",
	"The level the character was upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.Traits"] <- [
	"Traits",
	"The background and traits the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.PermInjuries"] <- [
	"Permanent Injuries",
	"The permanent injuries the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.Perks"] <- [
	"Perks",
	"The perks the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.HP"] <- [
	"Hitpoints",
	"The base hitpoints the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.FT"] <- [
	"Fatigue",
	"The base fatigue the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.BR"] <- [
	"Resolve",
	"The base resolve the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.IT"] <- [
	"Initiative",
	"The base initiative the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.MA"] <- [
	"Melee Skill",
	"The base melee skill the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.RA"] <- [
	"Ranged Skill",
	"The base ranged skill the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.MD"] <- [
	"Melee Defense",
	"The base melee defense the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.RD"] <- [
	"Ranged Defense",
	"The base ranged defense the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.swapperks"] <- [
	"Show Perks",
	@() "Swap the trait/permanent injuries columns for perks.\nHotkey: " + ::Legends.Obituary.getColoredKeybindText("toggle_perks")
];
::Legends.Obituary.Tooltip["world-screen.obituary.swapstats"] <- [
	"Swap Stat Order",
	@() "Swaps the position of first 4 stats (hp, fatigue, initiative, bravery) with the last 4 (attack / defense).\nHotkey: " + ::Legends.Obituary.getColoredKeybindText("toggle_stat_order")
];
::Legends.Obituary.Tooltip["world-screen.obituary.stackedstars"] <- [
	"Stacked Talent Stars",
	@() "Replace the 3 star talent icon (row of 3) with a triangle of stars.\nHotkey: " + ::Legends.Obituary.getColoredKeybindText("stacked_talent_stars")
];
::Legends.Obituary.Tooltip["AddToObituary"] <- [
	"Record their fate in the ledger",
	@() "This bro will be added to the obituary, the same as any deceased bro or those who left due to certain events.\n\nThe reason shown for their departure may vary, and the tone of the message depends on whether you paid them compensation when dismissing them."
];

// Generic positive text (with compensation)
::Legends.Obituary.FateText.PositiveMessages <- [
    "Dismissed from company",
    "Retired gracefully",
    "Left on good terms",
    "Parted amicably",
    "Honorable discharge",
    "Finished service with distinction",
    "Dismissed honorably",
    "Peaceful separation",
	"Returned home to recover",
	"Left with dignity",
	"A sorrowful parting",
	"Agreed it was time to part ways",
	"Decided to leave"
];

// Generic negative text (without compensation)
::Legends.Obituary.FateText.NegativeMessages <- [
    "Kicked from company",
    "Booted from the company",
    "Cast out for a terrible crime",
    "Fired unceremoniously",
    "Thrown out for mutiny",
    "Forced to leave",
    "Dismissed dishonorably",
    "Shamed the company. Sent packing",
	"Told to leave or die",
	"Abandoned in the wilds",
	"Got left in a swamp",
	"Got lost in a desert",
	"Vanished whilst on patrol",
	"Voted out by company majority",
	"A bitter parting",
	"Left in a terrible rage",
	"Banished for a transgression",
	"Left snoring in a tavern, useless sod",
	"Disliked immensely by all",
	"Left naked at a crossroads",
	"Cruelly injured and left behind",
	"Dropped for being dead weight",
	"Left to fend for themselves",
	"Stormed off after an argument",
	"Left us for a pretty face."
];

// Background-specific text
::Legends.Obituary.FateText.BackgroundMessages <- {
    [::Legends.Backgrounds.IDs.AdventurousNoble]              = { pos = "Set off on a new adventure",					neg = "" },
    [::Legends.Backgrounds.IDs.Anatomist]                      = { pos = "Resumed their forbidden studies",             	neg = "" },
    [::Legends.Backgrounds.IDs.Apprentice]                     = { pos = "Sought a new master",                         	neg = "" },
    [::Legends.Backgrounds.IDs.Assassin]                       = { pos = "Returned to the underworld",                  	neg = "" },
    [::Legends.Backgrounds.IDs.AssassinSouthern]              = { pos = "Returned to the underworld",                  	neg = "" },
    [::Legends.Backgrounds.IDs.Barbarian]                      = { pos = "Ventured back to the frozen north",           	neg = "" },
    [::Legends.Backgrounds.IDs.Bastard]                        = { pos = "Moved on without name or claim",              	neg = "" },
    [::Legends.Backgrounds.IDs.BeastSlayer]                   = { pos = "Took up the hunt for monsters once more",     	neg = "" },
    [::Legends.Backgrounds.IDs.Beggar]                         = { pos = "Worked the streets for more coin",            	neg = "Returned to the gutter" },
    [::Legends.Backgrounds.IDs.BellyDancer]                   = { pos = "Took their performance to new crowds",        	neg = "" },
    [::Legends.Backgrounds.IDs.Bowyer]                         = { pos = "Resumed work with wood and sinew",            	neg = "" },
    [::Legends.Backgrounds.IDs.Brawler]                        = { pos = "Sought a new fight",                          	neg = "" },
    [::Legends.Backgrounds.IDs.Butcher]                        = { pos = "Went back to the chopping block",             	neg = "" },
    [::Legends.Backgrounds.IDs.CaravanHand]                   = { pos = "Followed trade routes for their next job",    	neg = "" },
    [::Legends.Backgrounds.IDs.Companion]                      = { pos = "Parted ways and went their own path",         	neg = "" },
    [::Legends.Backgrounds.IDs.ConvertedCultist]              = { pos = "Clung to their newly found beliefs",          	neg = "" },
    [::Legends.Backgrounds.IDs.Cripple]                        = { pos = "Struggled on, earning coin where they could", 	neg = "Left to die in the gutter" },
    [::Legends.Backgrounds.IDs.Crucified]                      = { pos = "Bore their scars while seeking new work",     	neg = "" },
    [::Legends.Backgrounds.IDs.Crusader]                       = { pos = "Continued their righteous war",               	neg = "Took their unceasing zealotry elsewhere" },
    [::Legends.Backgrounds.IDs.Cultist]                        = { pos = "Slunk back to dark worship",                  	neg = "" },
    [::Legends.Backgrounds.IDs.Daytaler]                       = { pos = "Earned their daily coin and moved on",        	neg = "" },
    [::Legends.Backgrounds.IDs.Deserter]                       = { pos = "Kept hiding from banners and drums",          	neg = "" },
    [::Legends.Backgrounds.IDs.DisownedNoble]                 = { pos = "Continued their exile in comfort",            	neg = "Left in a rage, swearing revenge" },
    [::Legends.Backgrounds.IDs.Eunuch]                         = { pos = "Found quiet employment where needed",         	neg = "" },
    [::Legends.Backgrounds.IDs.Farmhand]                       = { pos = "Returned to the plow",                        	neg = "" },
    [::Legends.Backgrounds.IDs.Fisherman]                      = { pos = "Headed for familiar waters",                  	neg = "" },
    [::Legends.Backgrounds.IDs.Flagellant]                     = { pos = "Continued their path of painful penance",     	neg = "" },
    [::Legends.Backgrounds.IDs.Gambler]                        = { pos = "Chased fortune at dice and cards",            	neg = "Chased fortune and lost it all, again" },
    [::Legends.Backgrounds.IDs.Gladiator]                      = { pos = "Returned to blood-soaked arenas",             	neg = "" },
    [::Legends.Backgrounds.IDs.Gravedigger]                    = { pos = "Resumed digging graves for profit",           	neg = "" },
    [::Legends.Backgrounds.IDs.Graverobber]                    = { pos = "Resumed robbing the recently deceased",       	neg = "" },
    [::Legends.Backgrounds.IDs.HedgeKnight]                   = { pos = "Took to wandering battlefields again",        	neg = "" },
    [::Legends.Backgrounds.IDs.Historian]                      = { pos = "Lost themselves in dusty tomes",              	neg = "Their fate is lost to time" },
    [::Legends.Backgrounds.IDs.Houndmaster]                    = { pos = "Returned to beasts and leashes",              	neg = "" },
    [::Legends.Backgrounds.IDs.Hunter]                         = { pos = "Disappeared into the deep woods",             	neg = "" },
    [::Legends.Backgrounds.IDs.Juggler]                        = { pos = "Continued to entertain crowds",               	neg = "" },
    [::Legends.Backgrounds.IDs.KillerOnTheRun]              = { pos = "Kept running from the law",                   	neg = "Captured and hung within days of leaving" },
    [::Legends.Backgrounds.IDs.KingsGuard]                    = { pos = "Resumed sworn royal service",                 	neg = "" },
    [::Legends.Backgrounds.IDs.LindwurmSlayer]                = { pos = "Sought out legendary beasts once more",       	neg = "" },
    [::Legends.Backgrounds.IDs.Lumberjack]                     = { pos = "Returned to felling trees",                   	neg = "" },
    [::Legends.Backgrounds.IDs.Manhunter]                      = { pos = "Continued the pursuit of men",                	neg = "" },
    [::Legends.Backgrounds.IDs.Mason]                          = { pos = "Resumed work with stone and mortar",          	neg = "" },
    [::Legends.Backgrounds.IDs.Messenger]                      = { pos = "Carried words and warnings afar",             	neg = "" },
    [::Legends.Backgrounds.IDs.Militia]                        = { pos = "Went back to guarding their home",            	neg = "" },
    [::Legends.Backgrounds.IDs.Miner]                          = { pos = "Returned to the depths below",                	neg = "" },
    [::Legends.Backgrounds.IDs.Miller]                         = { pos = "Decided to grind grain for coin once more",   	neg = "" },
    [::Legends.Backgrounds.IDs.Minstrel]                       = { pos = "Set off to delight audiences anew",           	neg = "" },
    [::Legends.Backgrounds.IDs.Monk]                           = { pos = "Returned to quiet contemplation",             	neg = "" },
    [::Legends.Backgrounds.IDs.MonkTurnedFlagellant]         = { pos = "Embraced suffering as faith",                 	neg = "" },
    [::Legends.Backgrounds.IDs.Nomad]                          = { pos = "Drifted back to the shifting sands",          	neg = "" },
    [::Legends.Backgrounds.IDs.OrcSlayer]                     = { pos = "Hunted greenskins wherever hired",            	neg = "" },
    [::Legends.Backgrounds.IDs.PacifiedFlagellant]            = { pos = "Sought peace after years of pain",            	neg = "" },
    [::Legends.Backgrounds.IDs.Paladin]                        = { pos = "Continued their holy duty",                   	neg = "" },
    [::Legends.Backgrounds.IDs.Peddler]                        = { pos = "Went back to trade and barter",               	neg = "" },
    [::Legends.Backgrounds.IDs.Pimp]                           = { pos = "Returned to the gutter trade",                	neg = "Destined to be a bitter nobody" },
    [::Legends.Backgrounds.IDs.Poacher]                        = { pos = "Slipped back into illicit hunts",             	neg = "Lost in the woods, never seen again" },
    [::Legends.Backgrounds.IDs.Raider]                         = { pos = "Returned to pillage and bloodshed",           	neg = "Got arrested for murder" },
    [::Legends.Backgrounds.IDs.Ratcatcher]                     = { pos = "Returned to filth and vermin",                	neg = "Allegedly devoured by vermin" },
    [::Legends.Backgrounds.IDs.Refugee]                        = { pos = "Finally found a place to call home",          	neg = "Captured by slavers" },
    [::Legends.Backgrounds.IDs.RegentInAbsentia]             = { pos = "Ruled from afar once more",                   	neg = "" },
    [::Legends.Backgrounds.IDs.RetiredSoldier]                = { pos = "Laid down their arms for good",               	neg = "" },
    [::Legends.Backgrounds.IDs.Sellsword]                      = { pos = "Fought for coin elsewhere",                   	neg = "" },
    [::Legends.Backgrounds.IDs.Servant]                        = { pos = "Found a new master",                          	neg = "" },
    [::Legends.Backgrounds.IDs.Shepherd]                       = { pos = "Returned to their flock",                     	neg = "" },
    [::Legends.Backgrounds.IDs.Slave]                          = { pos = "Began a new life as a free man",              	neg = "Indebted once more" },
    [::Legends.Backgrounds.IDs.Squire]                         = { pos = "Sought a true knight to squire for",          	neg = "" },
    [::Legends.Backgrounds.IDs.Swordmaster]                    = { pos = "Devoted themselves to the blade",             	neg = "" },
    [::Legends.Backgrounds.IDs.Tailor]                         = { pos = "Returned to sewing clothes for coin",         	neg = "" },
    [::Legends.Backgrounds.IDs.Thief]                          = { pos = "Stole a girl\'s heart, settled down",         	neg = "Stole from a brother, dismissed" },
    [::Legends.Backgrounds.IDs.Vagabond]                       = { pos = "Drifted along the open road",                 	neg = "" },
    [::Legends.Backgrounds.IDs.Wildman]                        = { pos = "Wandered the wilds once more",                	neg = "" },
    [::Legends.Backgrounds.IDs.Witchhunter]                    = { pos = "Reported back to the guild",       	       	neg = "Believed killed by a hexen" },
    [::Legends.Backgrounds.IDs.LegendAlchemist]               = { pos = "Pursued the Philosopher's Stone", 			   	neg = "" },
    [::Legends.Backgrounds.IDs.LegendAncientSummoner]        = { pos = "Returned to esoteric practices", 			   	neg = "" },
    [::Legends.Backgrounds.IDs.LegendAstrologist]             = { pos = "Found meaning in the stars", 				   	neg = "" },
    [::Legends.Backgrounds.IDs.LegendBattleSister]           = { pos = "Fought evil wherever she found it", 		   	neg = "Went back to the kitchen" },
    [::Legends.Backgrounds.IDs.LegendCommanderBeggar]        = { pos = "", 										   	neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderBeggarScaling]     = { pos = "", 										   	neg = "" },
    [::Legends.Backgrounds.IDs.LegendBerserker]               = { pos = "Left to lead a pack of crazed warriors", 		neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderBerserker]     = { pos = "Left to lead a pack of crazed warriors", 		neg = "" },
    [::Legends.Backgrounds.IDs.LegendBlacksmith]              = { pos = "Returned to the heat of the forge", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendBladedancer]             = { pos = "Returned to the searing desert sands", 		neg = "" },
    [::Legends.Backgrounds.IDs.LegendBountyHunter]           = { pos = "Tracked down a high-value target", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendCannibal]                = { pos = "Found a new source of meat", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderAssassin]      = { pos = "Founded a deadly martial arts school", 	   	neg = "" },
    [::Legends.Backgrounds.IDs.LegendCompanionMelee]         = { pos = "Retired to become an innkeeper", 				neg = "Never forgave your betrayal" },
    [::Legends.Backgrounds.IDs.LegendCompanionRanged]        = { pos = "Retired to become an innkeeper", 				neg = "Never forgave your betrayal" },
    [::Legends.Backgrounds.IDs.LegendConjurer]                = { pos = "Found a new calling as an entertainer", 		neg = "" },
    [::Legends.Backgrounds.IDs.LegendConscript]               = { pos = "Found a new regiment to serve", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendCrusader]                = { pos = "Marched toward a new holy site", 				neg = "Headed deep into the desert, alone" },
    [::Legends.Backgrounds.IDs.LegendDeathSummoner]          = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendDervish]                 = { pos = "Returned to serve their faith", 				neg = "Left to seek penance" },
    [::Legends.Backgrounds.IDs.LegendDiviner]                 = { pos = "Saw a new future for themselves", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendDonkey]                  = { pos = "Left for greener pastures", 					neg = "Was sold to the butcher" },
    [::Legends.Backgrounds.IDs.LegendDruid]                   = { pos = "Returned to the sacred groves", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderDruid]         = { pos = "Returned to the sacred groves", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendEnchanter]               = { pos = "Left to pursue new arcane theories", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendEntrancer]               = { pos = "Fell under the spell of a fine woman", 		neg = "Fell under the spell of a hexen" },
    [::Legends.Backgrounds.IDs.LegendGuildmaster]             = { pos = "Returned to manage the guild", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendHealer]                  = { pos = "Mended wounds in a distant village", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendHerbalist]               = { pos = "Founded a potions shop", 						neg = "" },
    [::Legends.Backgrounds.IDs.LegendHorse]                   = { pos = "Began a new life roaming the steppes", 		neg = "Eaten by the men" },
    [::Legends.Backgrounds.IDs.LegendHorserider]              = { pos = "Found employment in noble stables", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendHorseCourser]           = { pos = "Joined a jousting company", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendHorseDestrier]          = { pos = "Rode off into the sunset", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendHorseRouncey]           = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendHusk]                    = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendIllusionist]             = { pos = "Vanished in a puff of smoke", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendInventor]                = { pos = "Setup a prosthesis shop", 						neg = "" },
    [::Legends.Backgrounds.IDs.LegendIronmonger]              = { pos = "Returned to the heat of the forge", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendLeechPeddler]           = { pos = "Headed into the swamps for new stock",		 	neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionAuxiliary]        = { pos = "Found a noble company to serve", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionCenturion]        = { pos = "Hired to a nobleman\'s retinue", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionGladiator]        = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionHonourGuard]     = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionLegate]           = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionLegionary]        = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionPrefect]          = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendLegionSlave]          = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendLonewolf]                = { pos = "Returned to the solitary path", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendLurker]                  = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendMagister]                = { pos = "Returned to the archive arcana", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendManAtArms]             = { pos = "Found a new lord to serve", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendMasterArcher]           = { pos = "Hired by a noble family as a tutor", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendMuladi]                  = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendNecromancer]             = { pos = "Sought unimaginable power", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendNecrosavant]             = { pos = "Left for a forbidden place", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendNecro]                   = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderNecro]         = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendNightwatch]              = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendNoble]        = { pos = "Returned to their noble house", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendNoble2h]                = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderNoble]         = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendNobleRanged]            = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendNobleShield]            = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderPeddler]       = { pos = "Went back to trade and barter", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendPhilosopher]             = { pos = "Found the meaning of life", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendPilgrim]                 = { pos = "Reached their sacred destination", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendPremonitionist]          = { pos = "They saw what fate had in store for them", 	neg = "Failed to see their own death coming" },
    [::Legends.Backgrounds.IDs.LegendPreserver]               = { pos = "Found a new calling selling fruit preserves", 	neg = "" },
    [::Legends.Backgrounds.IDs.LegendPuppet]                  = { pos = "Death was only the beginning", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendPuppetMaster]           = { pos = "Found new toys to play with", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendQiyan]                   = { pos = "Found shady employment elsewhere", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendRanger]                  = { pos = "Disappeared into the wild frontiers", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderRanger]        = { pos = "Disappeared into the wild frontiers", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendRunesmith]               = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendShieldmaiden]            = { pos = "Left to join a group of famed companions", 	neg = "" },
    [::Legends.Backgrounds.IDs.LegendSpiritualist]            = { pos = "Experienced a new spiritual awakening", 		neg = "" },
    [::Legends.Backgrounds.IDs.LegendSurgeon]                 = { pos = "Saved lives elsewhere", 						neg = "" },
    [::Legends.Backgrounds.IDs.LegendTaxidermist]             = { pos = "Pursuing their dream of a stuffed lindwurm", 	neg = "Arrested for erotic taxidermy" },
    [::Legends.Backgrounds.IDs.LegendTrader]                  = { pos = "Found a new market for their goods", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderTrader]        = { pos = "Found a new market for their goods", 			neg = "" },
    [::Legends.Backgrounds.IDs.LegendTransmuter]              = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendVala]                    = { pos = "Continued healing the world", 					neg = "" },
    [::Legends.Backgrounds.IDs.LegendWarlock]                 = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendWarlockSummoner]        = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.IDs.LegendWitch]                   = { pos = "Joined a foul coven", 							neg = "Hunted by the hexenjager" },
    [::Legends.Backgrounds.IDs.LegendCommanderWitch]         = { pos = "Established a new coven of misery", 			neg = "Killed by a hexenjager, some say the Wight" },
    [::Legends.Backgrounds.IDs.LegendYoungblood]              = { pos = "Found a new cause to fight for", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendMage]                = { pos = "Sought a legendary arcane tome", 				neg = "" },
    [::Legends.Backgrounds.IDs.LegendCommanderMage]     = { pos = "", 											neg = "" }
};
