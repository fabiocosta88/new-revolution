local mType = Game.createMonsterType("Infernal Phantom")
local monster = {}

monster.description = "a infernal phantom"
monster.experience = 22880
monster.outfit = {
	lookType = 1298,
	lookHead = 114,
	lookBody = 80,
	lookLegs = 94,
	lookFeet = 78,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1933
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 5000,
	FirstUnlock = 25,
	SecondUnlock = 3394,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Claustrophobic Inferno."
	}

monster.health = 26000
monster.maxHealth = 26000
monster.race = "undead"
monster.corpse = 34125
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 15
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Ashes to ashes.", yell = false},
	{text = "Burn, baby! Burn!", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 70540},
	{name = "platinum coin", chance = 82220, maxCount = 32},
	{name = "terra rod", chance = 21920},
	{name = "ultimate health potion", chance = 32220, maxCount = 7},
	{name = "hailstorm rod", chance = 71920},
	{name = "fire axe", chance = 18920},
	{name = "titan axe", chance = 18920},
	{name = "chaos mace", chance = 12920},
	{name = "glorious axe", chance = 22920},
	{name = "underworld rod", chance = 32920},
	{name = "springsprout rod", chance = 36920},
	{name = "wand of starstorm", chance = 36920},
	{name = "wand of voodoo", chance = 24920},
	{name = "warrior's axe", chance = 17920},
	{id = 34139, chance = 11560}, -- infernal heart
	{id = 34146, chance = 7560}, -- infernal robe
	{id = 34109, chance = 50} -- bag you desire
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -250, maxDamage = -800},
	--strike fogo
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -950, maxDamage = -1300, range = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_HITBYFIRE, target = false},
	--wave
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -980, maxDamage = -1150, radius = 3, effect = CONST_ME_FIREAREA, target = false},
	--sd em area -- quebra wall
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -900, maxDamage = -1350, range = 7, radius = 4, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true},
	--exori de mort
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -850, maxDamage = -1200, radius = 3, effect = CONST_ME_DEATHAREA, target = false}, 
}

monster.defenses = {
	defense = 75,
	armor = 100
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -10},
	{type = COMBAT_ENERGYDAMAGE, percent = 1},
	{type = COMBAT_EARTHDAMAGE, percent = -10},
	{type = COMBAT_FIREDAMAGE, percent = 80},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -20},
	{type = COMBAT_HOLYDAMAGE , percent = -20},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)