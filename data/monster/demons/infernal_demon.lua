local mType = Game.createMonsterType("Infernal Demon")
local monster = {}

monster.description = "a infernal demon"
monster.experience = 23340
monster.outfit = {
	lookType = 1313,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1938
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

monster.health = 32000
monster.maxHealth = 32000
monster.race = "blood"
monster.corpse = 33901
monster.speed = 200
monster.manaCost = 0

monster.changeTarget = {
	interval = 6000,
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
	canWalkOnEnergy = false,
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
	{text = "The smell of fear follows you.", yell = false},
	{text = "Your soul will burn.", yell = false}
}

monster.loot = {
	{name = "crystal coin", chance = 70540},
	{name = "ultimate health potion", chance = 32220, maxCount = 3},
	{name = "small diamond", chance = 65560, maxCount = 6},
	{name = "gold ingot", chance = 25560},
	{name = "blue crystal splinter", chance = 25560},
	{name = "cyan crystal fragment", chance = 25560},
	{name = "red crystal fragment", chance = 25560},
	{name = "magma boots", chance = 35500},
	{name = "blue gem", chance = 65560},
	{name = "giant sword", chance = 13500},
	{name = "war axe", chance = 9500},
	{name = "mercenary sword", chance = 11500},
	{name = "green crystal fragment", chance = 9500},
	{name = "onyx chip", chance = 7500},
	{id = 34109, chance = 50} -- bag you desire
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -350, maxDamage = -1450},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1150, maxDamage = -1400, effect = CONST_ME_FIREATTACK, shootEffect = CONST_ANI_FIRE, range = 3, target = true},
	{name ="combat", interval = 3000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -650, maxDamage = -1200, length = 8, effect = CONST_ME_EXPLOSIONHIT, target = false},
	{name ="combat", interval = 4000, chance = 35, type = COMBAT_DEATHDAMAGE, minDamage = -1000, maxDamage = -1350, radius = 4, effect = CONST_ME_MORTAREA, target = false},
	{name ="infernal demon chain", interval = 5000, chance = 5, minDamage = -0, maxDamage = -0, range = 5, effect = CONST_ME_DEATHAMAGE, target = true}
}

monster.defenses = {
	defense = 110,
	armor = 120,
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 650, maxDamage = 1200, effect = CONST_ME_MAGIC_RED, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 40},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -20},
	{type = COMBAT_HOLYDAMAGE , percent = -25},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)