local mType = Game.createMonsterType("Goshnar's Hatred")
local monster = {}

monster.description = "the goshnar's hatred"
monster.experience = 1000000
monster.outfit = {
	lookType = 1307,
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
    {id = 3041, chance = 28000, maxCount = 3}, -- blue gem
	{id = 281, chance = 30000}, -- giant shimmering pearl (green)
	{id = 282, chance = 30000}, -- giant shimmering pearl (brown)
	{id = 30059, chance = 38500}, -- giant ruby
	{id = 30060, chance = 38500}, -- giant emerald
	{id = 32622, chance = 38500}, -- giant amethyst
    {id = 33927, chance = 15000}, -- vial of hatred
    {id = 34076, chance = 8000}, -- bracelet of strengthening
    {id = 34020, chance = 6000}, -- figurine of hatred
    {id = 34109, chance = 1000, unique = true} -- bag you desire
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -1000, maxDamage = -2000},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -1500, maxDamage = -2000, radius = 5, effect = CONST_ME_EXPLOSIONHIT, target = true},
	{name ="combat", interval = 4000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -1100, maxDamage = -1550, radius = 3, effect = CONST_ME_FIREATTACK, target = false}, 
	{name ="combat", interval = 3000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1500, maxDamage = -2500, length = 8, spread = 0, effect = CONST_ME_HITBYFIRE, target = false},
	{name ="goshnar's hatred chain", interval = 5000, chance = 10, minDamage = -0, maxDamage = -0, range = 5, effect = CONST_ME_HITBYFIRE, target = true}
}

monster.defenses = {
	defense = 150,
	armor = 150
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 10},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 50},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
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
