local config = {
	bossName = "Urmahlullu the Immaculate",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 10, -- In minutes
	clearRoomTime = 10, -- In minutes
	daily = true,
	centerRoom = Position(33919, 31648, 8),
	playerPositions = {
		Position(33918, 31626, 8),
		Position(33919, 31626, 8),
		Position(33920, 31626, 8),
		Position(33921, 31626, 8),
		Position(33922, 31626, 8)
	},
	teleportPosition = Position(33919, 31657, 8),
	bossPosition = Position(33918, 31641, 8),
	specPos = Position(33920, 31608, 8),
	storage = Storage.Kilmaresh.UrmahlulluTimer
}

local urmahlulluLever = Action()
function urmahlulluLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == config.leverId then
		-- Check if the player that pulled the lever is on the correct position
		if player:getPosition() ~= config.playerPositions[1] then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can\'t start the battle.")
			return true
		end

		local team, participant = {}
		for i = 1, #config.playerPositions do
			participant = Tile(config.playerPositions[i]):getTopCreature()

			-- Check there is a participant player
			if participant and participant:isPlayer() then
				-- Check participant level
				if participant:getLevel() < config.requiredLevel then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "All the players need to be level ".. config.requiredLevel .." or higher.")
					return true
				end

				-- Check participant boss timer
				if config.daily and participant:getStorageValue(config.storage) > os.time() then
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You or a member in your team have to wait ".. config.timeToFightAgain .."  hours to face Urmahlullu again!")
					return true
				end
				team[#team + 1] = participant
			end
		end

		-- Check if a team currently inside the boss room
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 14, 14)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with Urmahlullu.")
				return true
			end
			spec:remove()
		end

		-- One hour for clean the room
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom)
		Game.createMonster(config.bossName, config.bossPosition)

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			team[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have ".. config.timeToDefeatBoss .." minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
			-- Assign boss timer
			team[i]:setStorageValue(config.storage, os.time() + config.timeToFightAgain * 60 * 60) -- 20 hours
			item:transform(config.leverId)

			addEvent(function()
				local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 14, 14)
					for i = 1, #specs do
						spec = specs[i]
						if spec:isPlayer() then
							spec:teleportTo(config.specPos)
							spec:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
							spec:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
						end
					end
			end, config.timeToDefeatBoss * 60 * 1000)
		end
	end
	return true
end

urmahlulluLever:uid(9545)
urmahlulluLever:register()