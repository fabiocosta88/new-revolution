local internalNpcName = "Jorge"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 159,
	lookHead = 38,
	lookBody = 77,
	lookLegs = 78,
	lookFeet = 94
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
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local items = {
	 [1] = {name = "Abacus", id = 19151},
	 [2] = {name = "Assassin Doll", id = 28897},
	 [3] = {name = "Bag of Oriental Spices", id = 23682},
	 [4] = {name = "Bookworm Doll", id = 28895},
	 [5] = {name = "Cateroide's Doll", id = 22151},
	 [6] = {name = "Doll of Durin the Almighty", id = 23679},
	 [7] = {name = "Dragon Eye", id = 22027},
	 [8] = {name = "Dragon Goblet", id = 31265},
	 [9] = {name = "Draken Doll", id = 25979},
	 [10] = {name = "Friendship Amulet", id = 19153},
	 [11] = {name = "Frozen Heart", id = 19156},
	 [12] = {name = "Golden Falcon", id = 28896},
	 [13] = {name = "Golden Newspaper", id = 23681},
	 [14] = {name = "Goromaphone", id = 34210},
	 [15] = {name = "Hand Puppets", id = 23676},
	 [16] = {name = "Imortus", id = 23683},
	 [17] = {name = "Jade Amulet", id = 31268},
	 [18] = {name = "Key of Numerous Locks", id = 19152},
	 [19] = {name = "Little Adventurer Doll", id = 37058},
	 [20] = {name = "Loremaster Doll", id = 31267},
	 [21] = {name = "Lucky Clover Amulet", id = 37059},
	 [22] = {name = "Mathmaster Shield", id = 25982},
	 [23] = {name = "Medusa Skull", id = 23680},
	 [24] = {name = "Music Box", id = 23677},
	 [25] = {name = "Noble Sword", id = 22028},
	 [26] = {name = "Norseman Doll", id = 19150},
	 [27] = {name = "Old Radio", id = 28894},
	 [28] = {name = "Orcs Jaw Shredder", id = 19155},
	 [29] = {name = "Pigeon Trophy", id = 31266},
	 [30] = {name = "Phoenix Statue", id = 22026},
	 [31] = {name = "Shield of Endless Search", id = 37060},
	 [32] = {name = "The Mexcalibur", id = 19154},
	 [33] = {name = "Tibiacity Encyclopedia", id = 8149},
	 [34] = {name = "TibiaHispano Emblem", id = 25980},
}

local function greetCallback(npc, creature)
	local playerId = creature:getId()
	npcHandler:setMessage(MESSAGE_GREET, "Hello " .. creature:getName() .. ", I sell {souvenirs} from the old tibia fan sites.")
		return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end


	if message then
		for i = 1, #items do
			if MsgContains(message, "souvenirs") then
				npcHandler:say("Here is a list of my souvenirs: {Abacus}, {Assasin Doll}, {Bag of Oriental Spices}, {Bookworm Doll}, {Cateroide's Doll}, {Doll of Durin the Almighty}, {Dragon Eye}, {Dragon Goblet}, {Draken Doll}, {Friendship Amulet}, {Frozen Heart}, {Golden Falcon}, {Golden Newspaper}, {Goromaphone}, {Hand Puppets}, {Imortus}, {Jade Amulet}, {Key of Numerous Locks}, {Little Adventurer Doll}, {Loremaster Doll}, {Lucky Clover Amulet}, {Mathmaster Shield}, {Medusa Skull}, {Music Box}, {Noble Sword}, {Norseman Doll}, {Old Radio}, {Orcs Jaw Shredder}, {Pigeon Trophy}, {Phoenix Statue}, {Shield of Endless Search}, {The Mexcalibur}, {Tibiacity Encyclopedia} and {TibiaHispano Emblem}", npc, creature)
			end
			if MsgContains(message, items[i].name) then
					if getPlayerItemCount(creature, 19083) >= 20 then
						doPlayerRemoveItem(creature, 19083, 20)
						doPlayerAddItem(creature, items[i].id, 1)
						selfSay('You just swapped 20 silver raid tokens for 1 '.. getItemName(items[i].name) ..'.', npc, creature)
					else
						selfSay('You need 20 silver raid tokens to buy 1 ' .. getItemName(items[i].name) .. '.', npc, creature)
					end
				end
		end
	end
	return true
end

local function onAddFocus(npc, creature)
	local playerId = creature:getId()
end

local function onReleaseFocus(npc, creature)
	local playerId = creature:getId()
end

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
