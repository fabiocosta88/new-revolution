local mType = Game.createMonsterType("Brachiodemon")
local monster = {}

monster.description = "a brachiodemon"
monster.experience = 22880
monster.outfit = {
	lookType = 1299,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1930
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 5000,
	FirstUnlock = 25,
	SecondUnlock = 3394,
	CharmsPoints = 100,
	Stars = 5,
	Occurrence = 0,
	Locations = "Claustrophobic Inferno."
	}

monster.health = 25000
monster.maxHealth = 25000
monster.race = "blood"
monster.corpse = 33817
monster.speed = 220
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20
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
	targetDistance = 1,
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
	{text = "Feel the heat!", yell = false},
	{text = "Hand over your life.", yell = false},
	{text = "I can give you a hand... or two.", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 70540},
	{name = "platinum coin", chance = 90540, maxCount = 32},
	{name = "ultimate health potion", chance = 32220, maxCount = 7},
	{id = 33936, chance = 35560}, -- hand
	{name = "skull staff", chance = 65560},
	{name = "epee", chance = 75560},
	{name = "crystal mace", chance = 25560},
	{name = "noble axe", chance = 8560},
	{name = "spellbook of mind control", chance = 9000},
	{id = 33937, chance = 7500}, -- head
	{name = "fire axe", chance = 13500},
	{name = "royal helmet", chance = 15500},
	{name = "mastermind shield", chance = 9500},
	{name = "assassin dagger", chance = 8500},
	{name = "butcher's axe", chance = 7500},
	{name = "jade hammer", chance = 6500},
	{name = "crystalline sword", chance = 5500},
	{name = "alloy legs", chance = 4500},
	{name = "metal bat", chance = 3500},
	{id = 23531, chance = 8920}, -- ring of green plasma
	{id = 34025, chance = 1550}, -- diabolic skull
	{id = 34109, chance = 50} -- bag you desire
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -250, maxDamage = -800},
	--sd em area -- quebra wall
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -1150, maxDamage = -1460, range = 7, radius = 4, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true},
	--exori de fogo
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -1100, maxDamage = -1550, radius = 3, effect = CONST_ME_FIREAREA, target = false}, 
	--exori de mort
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_DEATHDAMAGE, minDamage = -900, maxDamage = -1280, radius = 3, effect = CONST_ME_DEATHAREA, target = false}, 
}

monster.defenses = {
	defense = 90,
	armor = 105
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 30},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -25},
	{type = COMBAT_HOLYDAMAGE , percent = -35},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)