local mType = Game.createMonsterType("Thaian")
local monster = {}

monster.description = "Thaian"
monster.experience = 50000
monster.outfit = {
	lookTypeEx = 32695
}

monster.health = 200000
monster.maxHealth = 200000
monster.race = "undead"
monster.corpse = 5972
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8
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
	canPushItems = false,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 100,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
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
	{name = "crystal coin", chance = 100000, maxCount = 3},
	{name = "diamond", chance = 65000, maxCount = 3},
	{name = "ultimate mana potion", chance = 65000, maxCount = 6},
	{name = "white gem", chance = 55000, maxCount = 2},
	{name = "supreme health potion", chance = 65000, maxCount = 6},
	{name = "mastermind potion", chance = 70000, maxCount = 8},
	{name = "cursed bone", chance = 45000, maxCount = 1},
	{name = "berserk potion", chance = 60000, maxCount = 8},
	{name = "death toll", chance = 45000, maxCount = 3},
	{name = "spooky hood", chance = 15000, maxCount = 1},
	{name = "bullseye potion", chance = 55000, maxCount = 8},
	{name = "ultimate spirit potion", chance = 55000, maxCount = 6},
	{name = "moonstone", chance = 35000, maxCount = 2},
	{name = "ivory comb", chance = 65000, maxCount = 1},
	{name = "amber with a dragonfly", chance = 35000, maxCount = 1},
	{name = "brain head's right hemisphere", chance = 10000, maxCount = 1},
	{name = "brain head's left hemisphere", chance = 10000, maxCount = 1},
	{name = "phantasmal axe", chance = 5000, maxCount = 1},
	{name = "giant amethyst", chance = 5000, maxCount = 1},
	{name = "ghost claw", chance = 5000, maxCount = 1}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -650, maxDamage = -1200},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -450, maxDamage = -750, range = 7, shootEffect = CONST_ANI_POISON, target = false},
	{name ="speed", interval = 2000, chance = 25, speedChange = -850, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true, duration = 12000},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_LIFEDRAIN, minDamage = -650, maxDamage = -900, length = 8, spread = 3, effect = CONST_ME_SOUND_RED, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_EARTHDAMAGE, minDamage = -500, maxDamage = -1000, length = 8, spread = 3, effect = CONST_ME_POISONAREA, target = false}
}

monster.defenses = {
	defense = 50,
	armor = 100
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 15},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = 15},
	{type = COMBAT_LIFEDRAIN, percent = 15},
	{type = COMBAT_MANADRAIN, percent = 15},
	{type = COMBAT_DROWNDAMAGE, percent = 15},
	{type = COMBAT_ICEDAMAGE, percent = 15},
	{type = COMBAT_HOLYDAMAGE , percent = 15},
	{type = COMBAT_DEATHDAMAGE , percent = 15}
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
