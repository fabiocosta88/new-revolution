local mType = Game.createMonsterType("Brain Head")
local monster = {}

monster.description = "Brain Head"
monster.experience = 50000
monster.outfit = {
	lookTypeEx = 32418
}

monster.health = 230000
monster.maxHealth = 230000
monster.race = "undead"
monster.corpse = 32272
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
	runHealth = 0,
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
	{name ="melee", interval = 2000, chance = 100, minDamage = -450, maxDamage = -1000},
	{name ="combat", interval = 2500, chance = 25, type = COMBAT_ENERGYDAMAGE, minDamage = -500, maxDamage = -1110, radius = 4, shootEffect = CONST_ANI_ENERGY, target = true},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -800, maxDamage = -1350, radius = 4, effect = CONST_ME_ENERGYAREA, target = false}, 
}

monster.defenses = {
	defense = 50,
	armor = 100
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 100},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 30},
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
