local config = {
	bossName = "The Fear Feaster",
	summon_1 = "Fear",
	summon_2 = "Horror",
	summon_3 = "Phobia",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 15, -- In minutes
	clearRoomTime = 15, -- In minutes
	daily = true,
	centerRoom = Position(33711, 31469, 14),
	centerRoom1 = Position(33711, 31470, 15),
	playerPositions = {
		Position(33734, 31471, 14),
		Position(33735, 31471, 14),
		Position(33736, 31471, 14),
		Position(33737, 31471, 14),
		Position(33738, 31471, 14)
	},
	teleportPosition = Position(33711, 31476, 14),
	bossPosition_1 = Position(33711, 31469, 14),
	bossPosition_2 = Position(33710, 31467, 14),
	bossPosition_3 = Position(33711, 31467, 14),
	bossPosition_4 = Position(33712, 31467, 14),
	specPos = Position(33741, 31471, 14),
    storage = Storage.FeasterOfSouls.BossTimer.TheFearFeaster,
	storage_teleported = GlobalStorage.TheFearFeaster.Teleported1,
	storage_teleported1 = GlobalStorage.TheFearFeaster.Teleported2,
	storage_teleported2 = GlobalStorage.TheFearFeaster.Teleported3,
	storage_teleported3 = GlobalStorage.TheFearFeaster.Teleported4,
}

local fearfeaster = Action()
function fearfeaster.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You or a member in your team have to wait ".. config.timeToFightAgain .."  hours to face ".. config.bossName .." again!")
					return true
				end
				team[#team + 1] = participant
			end
		end

		-- Check if a team currently inside the boss room
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with ".. config.bossName ..".")
				return true
			end
			spec:remove()
		end
		local specs1, spec1 = Game.getSpectators(config.centerRoom1, false, false, 14, 14, 13, 13)
		for i = 1, #specs1 do
			spec1 = specs1[i]
			if spec1:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with ".. config.bossName ..".")
				return true
			end
			spec1:remove()
		end

		-- One hour for clean the room
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom)
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom1)

		Game.createMonster(config.bossName, config.bossPosition_1)
		Game.createMonster(config.summon_1, config.bossPosition_2)
		Game.createMonster(config.summon_2, config.bossPosition_3)
		Game.createMonster(config.summon_3, config.bossPosition_4)
		Game.setStorageValue(config.storage_teleported, 0)
		Game.setStorageValue(config.storage_teleported1, 0)
		Game.setStorageValue(config.storage_teleported2, 0)
		Game.setStorageValue(config.storage_teleported3, 0)

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			team[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have ".. config.timeToDefeatBoss .." minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
			-- Assign boss timer
			team[i]:setStorageValue(config.storage, os.time() + config.timeToFightAgain * 60 * 60) -- 20 hours
			item:transform(config.leverId)
			
			addEvent(function()
				local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
					for i = 1, #specs do
						spec = specs[i]
						if spec:isPlayer() then
							spec:teleportTo(config.specPos)
							spec:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
							spec:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
						end
					end
			end, config.timeToDefeatBoss * 60 * 1000)
			addEvent(function()
				local specs, spec = Game.getSpectators(config.centerRoom1, false, false, 14, 14, 13, 13)
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

fearfeaster:position({x = 33733, y = 31471, z = 14})
fearfeaster:register()