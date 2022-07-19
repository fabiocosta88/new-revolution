local config = {
	bossName = "The Nightmare Beast",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 15, -- In minutes
	clearRoomTime = 15, -- In minutes
	daily = true,
	centerRoom = Position(32208, 32044, 15),
	playerPositions = {
		Position(32212, 32070, 15),
		Position(32211, 32070, 15),
		Position(32210, 32070, 15),
		Position(32213, 32070, 15),
		Position(32214, 32070, 15),
		Position(32210, 32071, 15),
		Position(32211, 32071, 15),
		Position(32212, 32071, 15),
		Position(32213, 32071, 15),
		Position(32214, 32071, 15)

	},
	teleportPosition = Position(32208, 32052, 15),
	bossPosition = Position(32208, 32044, 15),
	specPos = Position(32211, 32084, 15),
	storage = Storage.Quest.U12_00.TheDreamCourts.TheNightmareBeastTimer
}

local function getCustomSpectators(position, multifloor, showPlayers, showMonsters, showNPCs, minRangeX, maxRangeX, minRangeY, maxRangeY)
    --getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
    local spectators = Game.getSpectators(position, multifloor, false, minRangeX, maxRangeX, minRangeY, maxRangeY)
    customSpectatorsList = {}
    for _, spectatorCreature in ipairs(spectators) do
        if (showPlayers and spectatorCreature:isPlayer()) or
            (showMonsters and spectatorCreature:isMonster()) or
            (showNPCs and spectatorCreature:isNpc()) then
            table.insert(customSpectatorsList, spectatorCreature)
        end
    end
    return customSpectatorsList
end

local function hasPlayers() 
	local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isPlayer() then
			return true
		end
	end
	return false
end

local function spawnTentacles()
	if hasPlayers() then
		local from = {x=32202,y=32040}
		local to = {x=32214,y=32049}
		local setX = math.random(from.x,to.x)
		local setY = math.random(from.y,to.y)
		local counter = 0
		local monsters = getCustomSpectators(config.centerRoom, false, true, true, true, 14, 14, 14, 14)
		for i = 1, #monsters do
			if monsters[i]:getName():lower() == "nightmare tendril" then
				counter = counter + 1
			end
		end
		if counter <= 4 then
			Game.createMonster("Nightmare Tendril", {x = setX, y=setY, z = 15})
		end
		addEvent(spawnTentacles, 5000)
	end
end

local thenightmarebeast = Action()
function thenightmarebeast.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
		end
		addEvent(function()
			spawnTentacles()
		end, 10000)
	end
	return true
end

thenightmarebeast:position({x = 32212, y = 32069, z = 15})
thenightmarebeast:register()