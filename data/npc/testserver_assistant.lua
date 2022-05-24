local internalNpcName = "Testserver Assistant"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 6000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 13,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0
}

npcConfig.flags = {
	floorchange = false
}

npcConfig.voices = {
	interval = 10000,
	chance = 50,
	{ text = 'Hey, free items, gold, coins, tournament points, level here!' }
}

function addTournamentCoins(player)
	local accountId = player:getAccountId()
	local resultId = db.storeQuery("SELECT `tournamentBalance` FROM `accounts` WHERE `id` = " .. accountId)
	local nowcoins = result.getDataInt(resultId, "tournamentBalance")
	result.free(resultId)
	local new_amount = nowcoins + 1000
	db.query("UPDATE `accounts` set `tournamentBalance` = " .. new_amount .. " WHERE id = " .. accountId)
    return true
end

function addExperience(player)
	player:addExperience(50000000)
end

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
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

keywordHandler:addKeyword({'tibia coin'}, StdModule.say, {npcHandler = npcHandler, text = 'Here is your 1000 tibia coins.'}, function(player) return player:addTibiaCoins(1000) end)
keywordHandler:addKeyword({'gold'}, StdModule.say, {npcHandler = npcHandler, text = 'Here is your money, 1000000 gold coins.'}, function(player) return player:addMoney(1000000) end)
keywordHandler:addKeyword({'tournament coin'}, StdModule.say, {npcHandler = npcHandler, text = 'Here is your 1000 tournament coins.'}, function(player) return addTournamentCoins(player) end)
keywordHandler:addKeyword({'level'}, StdModule.say, {npcHandler = npcHandler, text = 'Here is your experience points.'}, function(player) return addExperience(player) end)

npcHandler:setMessage(MESSAGE_FAREWELL, "Happy test, old chap!")
npcHandler:setMessage(MESSAGE_GREET, 'Welcome, |PLAYERNAME|. What you need? {tibia coin}, {gold}, {tournament coin}, {level} or {trade} and check my goods.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Oh! So rude.')
npcHandler:setMessage(MESSAGE_SENDTRADE, "Take all the time you need to decide what you want!")

npcHandler:addModule(FocusModule:new())

npcConfig.shop = {
	{ itemName = "soulcutter", clientId = 34082, buy = 1 },
    { itemName = "soulshredder", clientId = 34083, buy = 1 },
    { itemName = "soulbiter", clientId = 34084, buy = 1 },
    { itemName = "souleater", clientId = 34085, buy = 1 },
    { itemName = "soulcrusher", clientId = 34086, buy = 1 },
    { itemName = "soulmaimer", clientId = 34087, buy = 1 },
    { itemName = "soulbleeder", clientId = 34088, buy = 1 },
    { itemName = "soulpiercer", clientId = 34089, buy = 1 },
    { itemName = "soultainter", clientId = 34090, buy = 1 },
    { itemName = "soulhexer", clientId = 34091, buy = 1 },
    { itemName = "soulshanks", clientId = 34092, buy = 1 },
    { itemName = "soulstrider", clientId = 34093, buy = 1 },
    { itemName = "soulshell", clientId = 34094, buy = 1 },
    { itemName = "soulmantle", clientId = 34095, buy = 1 },
    { itemName = "soulshroud", clientId = 34096, buy = 1 },
    { itemName = "pair of soulwalkers", clientId = 34097, buy = 1 },
    { itemName = "pair of soulstalkers", clientId = 34098, buy = 1 },
    { itemName = "soulbastion", clientId = 34099, buy = 1 },
    { itemName = "falcon coif", clientId = 28715, buy = 1 },
    { itemName = "falcon rod", clientId = 28716, buy = 1 },
    { itemName = "falcon wand", clientId = 28717, buy = 1 },
    { itemName = "falcon bow", clientId = 28718, buy = 1 },
    { itemName = "falcon plate", clientId = 28719, buy = 1 },
    { itemName = "falcon greaves", clientId = 28720, buy = 1 },
    { itemName = "falcon shield", clientId = 28721, buy = 1 },
    { itemName = "falcon escutcheon", clientId = 28722, buy = 1 },
    { itemName = "falcon longsword", clientId = 28723, buy = 1 },
    { itemName = "falcon battleaxe", clientId = 28724, buy = 1 },
    { itemName = "falcon mace", clientId = 28725, buy = 1 },
    { itemName = "gnome legs", clientId = 27649, buy = 1 },
    { itemName = "cobra crossbow", clientId = 30393, buy = 1 },
    { itemName = "cobra boots", clientId = 30394, buy = 1 },
    { itemName = "cobra club", clientId = 30395, buy = 1 },
    { itemName = "cobra axe", clientId = 30396, buy = 1 },
    { itemName = "cobra hood", clientId = 30397, buy = 1 },
    { itemName = "cobra sword", clientId = 30398, buy = 1 },
    { itemName = "cobra wand", clientId = 30399, buy = 1 },
    { itemName = "cobra rod", clientId = 30400, buy = 1 },
    { itemName = "amulet of theurgy", clientId = 30401, buy = 1 },
    { itemName = "diamond arrow", clientId = 35901, buy = 1 },
    { itemName = "gold token", clientId = 22721, buy = 1 },
    { itemName = "silver token", clientId = 22516, buy = 1 },
    { itemName = "Ferumbras' hat", clientId = 5903, buy = 1 },
    { itemName = "spectral bolt", clientId = 25758, buy = 1 },
    { itemName = "winged boots", clientId = 31617, buy = 1 },
    { itemName = "void boots", clientId = 23476, buy = 1 },
    { itemName = "pair of dreamwalkers", clientId = 29424, buy = 1 },
    { itemName = "lion longbow", clientId = 34150, buy = 1 },
    { itemName = "lion rod", clientId = 34151, buy = 1 },
    { itemName = "lion wand", clientId = 34152, buy = 1 },
    { itemName = "lion spellbook", clientId = 34153, buy = 1 },
    { itemName = "lion shield", clientId = 34154, buy = 1 },
    { itemName = "lion longsword", clientId = 34155, buy = 1 },
    { itemName = "lion spangehelm", clientId = 34156, buy = 1 },
    { itemName = "lion plate", clientId = 34157, buy = 1 },
    { itemName = "lion amulet", clientId = 34158, buy = 1 },
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

-- npcType registering the npcConfig table
npcType:register(npcConfig)