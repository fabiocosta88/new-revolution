local mType = Game.createMonsterType("Goshnar's Malice")
local monster = {}

monster.description = "the goshnar's malice"
monster.experience = 1000000
monster.outfit = {
	lookType = 1306,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 1000000
monster.maxHealth = 1000000
monster.race = "blood"
monster.corpse = 33870
monster.speed = 500
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 25
}

monster.strategiesTarget = {
	nearest = 30,
	health = 50,
	damage = 10,
	random = 10,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "GOSHNAR'S MALICE PREPARES TO DEVOUR A TRAPPED SOUL!", yell = true},
}

monster.loot = {
    {id = 3043, chance = 100000, maxCount = 75}, -- crystal coin
    {id = 23375, chance = 85000, maxCount = 20}, -- supreme health potion
    {id = 23374, chance = 75000, maxCount = 20}, -- ultimate spirit potion
    {id = 23373, chance = 65000, maxCount = 20}, -- ultimate mana potion
    {id = 7443, chance = 35000, maxCount = 10}, -- bullseye potion
	{id = 7440, chance = 35000, maxCount = 10}, -- mastermind potion
	{id = 7439, chance = 28000, maxCount = 10}, -- berserk potion
    {id = 3037, chance = 28000, maxCount = 3}, -- yellow gem
    {id = 3039, chance = 28000, maxCount = 3}, -- red gem
    {id = 3036, chance = 28000, maxCount = 3}, -- violet gem
    {id = 32769, chance = 28000, maxCount = 3}, -- white gem
    {id = 3038, chance = 28000, maxCount = 3}, -- green gem
    {id = 3041, chance = 28000, maxCount = 3}, -- blue gem
	{id = 281, chance = 30000}, -- giant shimmering pearl (green)
	{id = 282, chance = 30000}, -- giant shimmering pearl (brown)
	{id = 30053, chance = 25000}, -- dragon figurine
	{id = 30061, chance = 38500}, -- giant sapphire
	{id = 32623, chance = 38500}, -- giant topaz
    {id = 34018, chance = 15000}, -- figurine of malice
    {id = 34076, chance = 8000}, -- bracelet of strengthening
    {id = 34075, chance = 6000}, -- the skull of a beast
    {id = 34072, chance = 4000}, -- the skull of a beast
    {id = 34109, chance = 1000, unique = true} -- bag you desire
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -2500, maxDamage = -3000},
    {name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -2000, maxDamage = -2500, radius = 5, effect = CONST_ME_ICEAREA, target = true},
    {name ="combat", interval = 4000, chance = 25, type = COMBAT_ICEDAMAGE, minDamage = -1500, maxDamage = -2000, range = 7, shootEffect = CONST_ANI_ICE, target = false},
    {name ="combat", interval = 4000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -2500, maxDamage = -4800, length = 8, spread = 0, effect = CONST_ME_GIANTICE, target = false},
    {name ="combat", interval = 2000, chance = 30, type = COMBAT_ICEDAMAGE, minDamage = -1500, maxDamage = -2500, length = 7, spread = 3, effect = CONST_ME_ICEATTACK, target = false}
}

monster.defenses = {
	defense = 150,
	armor = 150
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = 15},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 15},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
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
