local config = {
	bossName = "Duke Krule",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 15, -- In minutes
	clearRoomTime = 15, -- In minutes
	daily = true,
	centerRoom = Position(33456, 31473, 13),
	playerPositions = {
		Position(33455, 31493, 13),
		Position(33456, 31493, 13),
		Position(33457, 31493, 13),
		Position(33458, 31493, 13),
		Position(33459, 31493, 13)
	},
	summonPositions = {
		Position(33451, 31472, 13),
		Position(33457, 31467, 13),
		Position(33462, 31472, 13),
		Position(33456, 31478, 13),
	},
	teleportPosition = Position(33455, 31464, 13),
	bossPosition = Position(33456, 31473, 13),
	specPos = Position(33457, 31498, 13),
    storage = Storage.GraveDanger.BossTimer.DukeKruleTimer
}

local function hasPlayers()
	local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isPlayer() then
			return spec
		end
	end
	return false
end

local function countMonster()
    local counter = 0
	local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isMonster() then
			if spec:getName():lower() == "soul scourge" then
                counter = counter + 1
			end
		end
	end
    return counter
end

local function spawnSoulScourge()
	local player = hasPlayers()
	if player then 
		local counter = countMonster()
		if counter <= 3 then
			Game.createMonster("Soul Scourge", config.summonPositions[math.random(#config.summonPositions)])
		end
		addEvent(spawnSoulScourge, 10000)
	end
end

local dukekrule = Action()
function dukekrule.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
		addEvent(function()
			for i = 1, #config.summonPositions do
				Game.createMonster("Soul Scourge", config.summonPositions[i])
			end
		end,5000)
		addEvent(spawnSoulScourge, 15000)

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
	end
	return true
end

dukekrule:position({x = 33454, y = 31493, z = 13})
dukekrule:register()