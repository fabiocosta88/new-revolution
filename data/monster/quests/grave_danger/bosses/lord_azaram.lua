local mType = Game.createMonsterType("Lord Azaram")
local monster = {}

monster.description = "a Lord Azaram"
monster.experience = 41950
monster.outfit = {
	lookType = 1223,
	lookHead = 19,
	lookBody = 2,
	lookLegs = 94,
	lookFeet = 81,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 50000
monster.maxHealth = 50000
monster.race = "venom"
monster.corpse = 31599
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
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

monster.summon = {
	maxSummons = 3,
	summons = {
		{name = "Condensed Sins", chance = 50, interval = 2000, count = 3}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{name = "platinum coin", minCount = 1, maxCount = 5, chance = 100000},
	{name = "crystal coin", minCount = 0, maxCount = 2, chance = 50000},
	{name = "supreme health potion", minCount = 0, maxCount = 6, chance = 35000},
	{name = "ultimate mana potion", minCount = 0, maxCount = 20, chance = 32000},
	{name = "ultimate spirit potion", minCount = 0, maxCount = 20, chance = 32000},
	{name = "bullseye potion", minCount = 0, maxCount = 10, chance = 12000},
	{name = "berserk potion", minCount = 0, maxCount = 10, chance = 12000},
	{name = "piece of hell steel", minCount = 0, maxCount = 4, chance = 9000},
	{id= 3039, minCount = 0, maxCount = 2, chance = 12000}, -- red gem
	{name = "blue gem", minCount = 0, maxCount = 2, chance = 12000},
	{name = "silver token", minCount = 0, maxCount = 2, chance = 9500},
	{name = "ancient liche bone", chance = 5200},
	{id = 23542, chance = 5200}, -- collar of blue plasma
	{id = 23544, chance = 5200}, -- collar of red plasma
	{id = 23543, chance = 5200}, -- collar of green plasma
	{name = "giant sapphire", chance = 7000},
	{name = "haunted blade", chance = 9000},
	{name = "huge chunk of crude iron", chance = 4500},
	{name = "knight armor", chance = 15000},
	{name = "violet gem", minCount = 0, maxCount = 1, chance = 10000},
	{name = "yellow gem", minCount = 0, maxCount = 1, chance = 10000},
	{id = 23531, chance = 5000}, -- ring of green plasma
	{id = 23533, chance = 5000}, -- ring of red plasma
	{name = "young lich worm", chance = 5800},
	{name = "bear skin", chance = 1600},
	{name = "noble cape", chance = 1500},
	{name = "terra helmet", chance = 720},
	{name = "final judgement", chance = 410},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -600, maxDamage = -1200},
	{name ="combat", interval = 2000, chance = 35, type = COMBAT_EARTHDAMAGE, minDamage = -1000, maxDamage = -1900, length = 7, spread = 3, effect = CONST_ME_STONES, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_EARTHDAMAGE, minDamage = -800, maxDamage = -1800, length = 7, spread = 3, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -450, maxDamage = -1000, range = 7, effect = CONST_ME_MAGIC_RED, target = true},
	{name ="lord azaram chain", interval = 6000, chance = 10, minDamage = -0, maxDamage = -0, range = 5, effect = CONST_ME_POISONAREA, target = true}
}

monster.defenses = {
	defense = 25,
	armor = 78,
	{name ="combat", interval = 2000, chance = 50, type = COMBAT_HEALING, minDamage = 650, maxDamage = 1550, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
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
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
