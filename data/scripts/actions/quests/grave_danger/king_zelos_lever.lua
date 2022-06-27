local config = {
	bossName = "King Zelos",
	miniBossName1 = "The Red Knight",
	miniBossName2 = "Nargol The Impaler",
	miniBossName3 = "Magnor Mournbringer",
	miniBossName4 = "Rewar The Bloody",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 25, -- In minutes
	clearRoomTime = 25, -- In minutes
	daily = true,
	centerRoom = Position(33443, 31545, 13),
	playerPositions = {
		Position(33485, 31546, 13),
		Position(33485, 31547, 13),
		Position(33485, 31548, 13),
		Position(33485, 31545, 13),
		Position(33485, 31544, 13),
		Position(33486, 31546, 13),
		Position(33486, 31547, 13),
		Position(33486, 31548, 13),
		Position(33486, 31545, 13),
		Position(33486, 31544, 13)
	},
	teleportPosition = Position(33443, 31571, 13),
	bossPosition = Position(33443, 31545, 13),
	miniBossPosition1 = Position(33423, 31562, 13),
	miniBossPosition2 = Position(33423, 31529, 13),
	miniBossPosition3 = Position(33463, 31529, 13),
	miniBossPosition4 = Position(33463, 31562, 13),
	specPos = Position(33489, 31546, 13),
    storage = Storage.GraveDanger.BossTimer.KingZelos
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


local function spawnRisenSoldier()
	local spectators = getCustomSpectators(config.centerRoom, false, true, false, false, 14, 14, 14, 14)
	if spectators then
		local from = {x=33438,y=31540}
		local to = {x=33448,y=31551}
		local setX = math.random(from.x,to.x)
		local setY = math.random(from.y,to.y)
		local counter = 0
		local monsters = getCustomSpectators(config.centerRoom, false, true, true, true, 14, 14, 14, 14)
		for i = 1, #monsters do
			if monsters[i]:getName():lower() == "risen soldier" then
				counter = counter + 1
			end
		end
		if counter <= 4 then
			Game.createMonster("Risen Soldier", {x = setX, y=setY, z = 13})
		end
		addEvent(spawnRisenSoldier, 5000)
	end
end

local kingzelos = Action()
function kingzelos.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 31, 31, 31, 31)
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
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.miniBossPosition1)
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.miniBossPosition2)
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.miniBossPosition3)
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.miniBossPosition4)
		Game.createMonster(config.bossName, config.bossPosition)
		Game.createMonster(config.miniBossName1, config.miniBossPosition1)
		Game.createMonster(config.miniBossName2, config.miniBossPosition2)
		Game.createMonster(config.miniBossName3, config.miniBossPosition3)
		Game.createMonster(config.miniBossName4, config.miniBossPosition4)
		Game.setStorageValue(GlobalStorage.KingZelos.Minibosses, 0)

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			team[i]:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			team[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have ".. config.timeToDefeatBoss .." minutes to kill and loot " .. config.bossName .. ". Otherwise you will lose that chance and will be kicked out.")
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
	end
	return true
end

kingzelos:position({x = 33484, y = 31546, z = 13})
kingzelos:register()