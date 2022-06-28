local internalNpcName = "Stricken Soul"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 48
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "job") then
		npcHandler:say("I... was... not a servant. Not a lord nor a knight. I was a... traveller. Yeeeees. A scholar! I hoarded knowledge... some I would advise or teach. But of thoooooose I have no memory.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "scholar") then
		npcHandler:say("Yes, I am... a scholar! I teach... my knowledge... I can take you in as another student... just need to remember... your naaaaaame....", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "name") then
		npcHandler:say("I am... I was... I... it was such a looooong time ago.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 0 then
			npcHandler:say("Yeeeees... you need to help meeeeeee. I want those ghosts gone... this is my home and I need it to teach my students. Will you take care of the... ghosts?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Excellent... I hope they will haaaaaaunt my house no longer. What was your... naaaaaame again, tell me?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, player:getName():lower()) then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say({
				"Ah yeeeeees, " .. player:getName() .. "... I will remember you. Now, lessons are every day in the morning and once a week in the evening... ...",
				"Oh, you're not here for this, are you? So about the ghoooosts, yes. You seeeee, there are 3 secret passages here. ...",
				"Thiiiiis is no ordinary house... it is a nexus, a gateway to a once hidden cathedral. Sheltering a small and peaceful society of scholars and monks. Secluded from every distraction. ...",
				"I was one of them and ordered to hold contact to the outside woooorld. But then, something... happened. ...",
				"Outsiders managed to sneak in, infiltrate and influence the society... for the worse. Who knows for what ends. They chaaaaanged... ...",
				"Shortly after, contact was lost... the nexus broken and sealed, ghosts appeared... eeeeeeeverywhere. ...",
				"Find the three passages... one is right here in the cellars, one in the jungles of Tiquanda and one in the deserts of Darama. ...",
				"Restore their connection and open this nexus to access the buried cathedral and find the cause to this... eliminate all remainders there if you must, " .. player:getName() .. "."
			 }, npc, creature, 2000)
			 if player:getStorageValue(Storage.Quest.U12_00.TheDreamCourts.StrickenSoul) ~= 1 then
				player:setStorageValue(Storage.Quest.U12_00.TheDreamCourts.StrickenSoul, 1)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_GREET, "This place is... haunted... heed my warning... there are... ghooooooosts here...! Why are you giving me that... look? I am certain, there aaaaaaare ghosts here - I've seen them! Do you believe me?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Faaaaare thee well.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Faaaaare thee well.")
npcHandler:addModule(FocusModule:new())

-- npcType registering the npcConfig table
npcType:register(npcConfig)
