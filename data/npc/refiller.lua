local internalNpcName = "Refiller"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookType = 472,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 0,
	lookAddons = 3
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	if npc == nill then
		return false
	end
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

keywordHandler:addKeyword({"job"}, StdModule.say, {npcHandler = npcHandler, text = "I am a traveling salesman seeking to help all those who are allowed to summon me."})
keywordHandler:addKeyword({"name"}, StdModule.say, {npcHandler = npcHandler, text = "I am Refiller, son of the God."})
keywordHandler:addKeyword({"fabio"}, StdModule.say, {npcHandler = npcHandler, text = "He is my favorite God."})

npcHandler:setMessage(MESSAGE_GREET, "Ah, a customer! Be greeted, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back soon!")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Take all the time you need to decide what you want!")

local function onBye(npc, creature)
	npc:remove()
	return true
end

npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onBye)
npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)
npcHandler:addModule(FocusModule:new())

npcConfig.shop = {
	{ itemName = "empty potion flask", clientId = 283, sell = 5 },
	{ itemName = "empty potion flask", clientId = 284, sell = 5 },
	{ itemName = "empty potion flask", clientId = 285, sell = 5 },
	{ itemName = "great health potion", clientId = 239, buy = 225 },
	{ itemName = "great mana potion", clientId = 238, buy = 144 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 228 },
	{ itemName = "health potion", clientId = 266, buy = 50 },
	{ itemName = "mana potion", clientId = 268, buy = 56 },
	{ itemName = "strong health potion", clientId = 236, buy = 115 },
	{ itemName = "strong mana potion", clientId = 237, buy = 93 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 625 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 379 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 438 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 438 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 438 },
	{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
	{ itemName = "blank rune", clientId = 3147, buy = 10 },
	{ itemName = "crystal ball", clientId = 3076, buy = 530, sell = 190 },
	{ itemName = "desintegrate rune", clientId = 3197, buy = 26 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
	{ itemName = "exercise wand", clientId = 28557, buy = 262500, count = 500 },
	{ itemName = "fireball rune", clientId = 3189, buy = 30 },
	{ itemName = "holy missile rune", clientId = 3182, buy = 16 },
	{ itemName = "icicle rune", clientId = 3158, buy = 30 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
	{ itemName = "paralyze rune", clientId = 3165, buy = 700 },
	{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },
	{ itemName = "soulfire rune", clientId = 3195, buy = 46 },
	{ itemName = "springsprout rod", clientId = 8084, buy = 18000 },
	{ itemName = "stone shower rune", clientId = 3175, buy = 37 },
	{ itemName = "thunderstorm rune", clientId = 3202, buy = 47 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 160 }
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, inBackpacks, name, totalCost)
	npc:sellItem(player, itemId, amount, subType, true, inBackpacks, 2854)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Bought %ix %s for %i %s.", amount, name, totalCost, ItemType(npc:getCurrency()):getPluralName():lower()))
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, clientId, subtype, amount, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType)
end

npcType:register(npcConfig)
