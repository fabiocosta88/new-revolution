local mType = Game.createMonsterType("Malofur Mangrinder")
local monster = {}

monster.description = "Malofur Mangrinder"
monster.experience = 55000
monster.outfit = {
	lookType = 1120,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 320000
monster.maxHealth = 320000
monster.race = "blood"
monster.corpse = 30017
monster.speed = 250
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 50
}

monster.strategiesTarget = {
	nearest = 30,
	health = 10,
	damage = 50,
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
	{name = "ultimate spirit potion", chance = 50000, maxCount = 6},
	{name = "crystal coin", chance = 50000},
	{name = "ultimate mana potion", chance = 50000, maxCount = 14},
	{name = "supreme health potion", chance = 50000, maxCount = 6},
	{id = 281, chance = 100000}, -- giant shimmering pearl (green)
	{name = "green gem", chance = 100000},
	{id= 3039, chance = 50000}, -- red gem
	{name = "blue gem", chance = 100000},
	{id = 23529, chance = 50000}, -- ring of blue plasma
	{name = "platinum coin", chance = 50000, maxCount = 5},
	{name = "bullseye potion", chance = 50000, maxCount = 10},
	{name = "piggy bank", chance = 100000},
	{name = "mysterious remains", chance = 100000},
	{name = "energy bar", chance = 100000},
	{id = 23543, chance = 50000}, -- collar of green plasma
	{name = "ring of the sky", chance = 100000},
	{name = "crunor idol", chance = 41000},
	{name = "resizer", chance = 2000},
	{name = "shoulder plate", chance = 2000},
	{name = "malofur's lunchbox", chance = 2000},
	{name = "pomegranate", chance = 10000}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -250, maxDamage = -1150},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -550, maxDamage = -870, length = 8, spread = 3, effect = CONST_ME_FIREAREA, target = false},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_LIFEDRAIN, minDamage = -700, maxDamage = -1500, length = 8, spread = 0, effect = CONST_ME_SMOKE, target = false},
	{name ="malofur shockwave", interval = 2000, chance = 10, target = false},
	{name ="speed", interval = 2000, chance = 25, speedChange = -700, range = 7, radius = 4, shootEffect = CONST_ANI_POISON, effect = CONST_ME_GREEN_RINGS, target = true, duration = 15000},
}

monster.defenses = {
	defense = 95,
	armor = 90,
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_HEALING, minDamage = 500, maxDamage = 950, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 35},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 100},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.heals = {
	{type = COMBAT_FIREDAMAGE , percent = 500}
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
