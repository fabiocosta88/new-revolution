local mType = Game.createMonsterType("Brother Worm")
local monster = {}

monster.description = "a brother worm"
monster.experience = 25000
monster.outfit = {
	lookType = 295,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.events = {
	"brother_worm_damage"
}

monster.health = 300000
monster.maxHealth = 300000
monster.race = "undead"
monster.corpse = 0
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 6000,
	chance = 10
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
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 1,
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
	chance = 5,
	{text = "RUN!!!", yell = false},
}

monster.loot = {
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -250, maxDamage = -500, condition = {type = CONDITION_POISON, totalDamage = 4, interval = 4000}},
	{name ="combat", interval = 3000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -200, maxDamage = -550, radius = 3, effect = CONST_ME_GREEN_RINGS, target = false},
	{name ="askarak wave", interval = 2000, chance = 20, minDamage = -350, maxDamage = -700, target = false},
	{name ="combat", interval = 3000, chance = 45, type = COMBAT_FIREDAMAGE, minDamage = -600, maxDamage = -1200, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true},
	{name ="combat", interval = 3000, chance = 40, type = COMBAT_PHYSICALDAMAGE, minDamage = -1000, maxDamage = -1750, radius = 2, shootEffect = CONST_ANI_SMALLEARTH, target = false},
}

monster.defenses = {
	defense = 15,
	armor = 10,
	{name ="speed", interval = 10000, chance = 40, speedChange = 510, effect = CONST_ME_MAGIC_GREEN, target = false, duration = 20000},
	{name ="combat", interval = 5000, chance = 60, type = COMBAT_HEALING, minDamage = 800, maxDamage = 2500, effect = CONST_ME_MAGIC_BLUE, target = false},
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = -10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
