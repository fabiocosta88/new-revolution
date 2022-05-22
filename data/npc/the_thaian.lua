local internalNpcName = "The Thaian"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 0

npcConfig.outfit = {
	lookTypeEx = 32695
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

function sendToBoss(player)
	if not player then
		return false
	end

	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:teleportTo(Position(33899, 31885, 8))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end


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

keywordHandler:addKeyword({'boss'}, StdModule.say, {npcHandler = npcHandler,
		text = {
			'Good luck child ...',
		}}, function(player) return sendToBoss(player) end
	)

npcHandler:setMessage(MESSAGE_GREET, 'Welcome, adventure |PLAYERNAME|! If you are ready to fight say {boss}')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Remember: I dont forget.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Your soul is mine, |PLAYERNAME|!')

npcHandler:addModule(FocusModule:new())
-- npcType registering the npcConfig table
npcType:register(npcConfig)
