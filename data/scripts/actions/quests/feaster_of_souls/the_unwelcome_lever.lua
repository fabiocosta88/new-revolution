local config = {
	bossName = "The Unwelcome",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 15, -- In minutes
	clearRoomTime = 60, -- In minutes
	daily = true,
	centerRoom = Position(33708, 31539, 14),
	playerPositions = {
		Position(33736, 31537, 14),
		Position(33737, 31537, 14),
		Position(33738, 31537, 14),
		Position(33739, 31537, 14),
		Position(33740, 31537, 14)
	},
	teleportPosition = Position(33708, 31547, 14),
	bossPosition = Position(33708, 31539, 14),
	specPos = Position(33743, 31537, 14),
    storage = Storage.FeasterOfSouls.BossTimer.TheUnwelcome
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
			if spec:getName():lower() == "greed worm" then
                counter = counter + 1
			end
		end
	end
    return counter
end

local function spawnGreedWorm()
	local player = hasPlayers()
	if player then 
		local from = {x=33704,y=31534}
		local to = {x=33707,y=31544}
		local setX = math.random(from.x,to.x)
		local setY = math.random(from.y,to.y)
		local counter = countMonster()
		if counter <= 5 then
			Game.createMonster("Greed Worm", {x = setX, y=setY, z = 14})
		end
		addEvent(spawnGreedWorm, 5 * 1000)
	end
end

local unwelcome = Action()
function unwelcome.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
			Game.createMonster("Brother Worm", Position({x = 33703, y = 31540, z = 14}), false, true)
		end, 30000)
		addEvent(spawnGreedWorm, 10000)
	end
	return true
end

unwelcome:position({x = 33735, y = 31537, z = 14})
unwelcome:register()