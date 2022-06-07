local mType = Game.createMonsterType("Magnor Mournbringer")
local monster = {}

monster.description = "magnor mournbringer"
monster.experience = 0
monster.outfit = {
	lookType = 1221,
	lookHead = 19,
	lookBody = 76,
	lookLegs = 114,
	lookFeet = 76,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "blood"
monster.corpse = 0
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 25
}

monster.events = {
	"GDMiniDeath"
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
	canPushCreatures = true,
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
}

monster.loot = {
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -550},
	{name ="explosion wave", interval = 2000, chance = 14, minDamage = -450, maxDamage = -600, target = false},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_FIREDAMAGE, minDamage = -400, maxDamage = -750, radius = 5, effect = CONST_ME_EXPLOSIONHIT, target = false},
	{name ="combat", interval = 2000, chance = 12, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -930, radius = 4, effect = CONST_ME_FIREATTACK, target = false},
	-- energy damage
	{name ="condition", type = CONDITION_ENERGY, interval = 2000, chance = 18, minDamage = -300, maxDamage = -400, radius = 6, effect = CONST_ME_ENERGYHIT, target = false},
	-- fire
	{name ="condition", type = CONDITION_FIRE, interval = 3000, chance = 20, minDamage = -500, maxDamage = -600, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true}
}

monster.defenses = {
	defense = 110,
	armor = 100
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
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
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
