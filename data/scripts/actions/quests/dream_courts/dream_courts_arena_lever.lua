local config = {
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 15, -- In minutes
	clearRoomTime = 15, -- In minutes
	daily = true,
	centerRoom = Position(32208, 32047, 14),
	playerPositions = {
		Position(32208, 32021, 13),
        Position(32208, 32022, 13),
        Position(32208, 32023, 13),
        Position(32208, 32024, 13),
        Position(32208, 32025, 13)
	},
	teleportPosition = Position(32223, 32048, 14),
	bossPosition = Position(32208, 32047, 14),
	specPos = Position(32208, 32035, 13),
	storage = Storage.Quest.U12_00.TheDreamCourts.ArenaBossTimer
}

local function getBossName()
    local bossNum = Game.getStorageValue(GlobalStorage.DreamCourtsBoss)
    if not bossNum then
        return "error"
    end
    if bossNum == 1 then
        return "Alptramun"
    elseif bossNum == 2 then
        return "Izcandar the Banished"
    elseif bossNum == 3 then
        return "Malofur Mangrinder"
    elseif bossNum == 4 then
        return "Maxxenius"
    elseif bossNum == 5 then
        return "Plagueroot"
    end
end

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

local function spawnSummons()
    if getBossName() == "Maxxenius" then
        Game.createMonster("Generator", Position(32205, 32048, 14))
        Game.createMonster("Generator", Position(32210, 32045, 14))
        Game.createMonster("Generator", Position(32210, 32051, 14))
	elseif getBossName() == "Alptramun" then
		Game.createMonster("Horrible Dream", Position(32206, 32046, 14))
        Game.createMonster("Mind-wrecking Dream", Position(32209, 32047, 14))
        Game.createMonster("Nightmarish Dream", Position(32207, 32049, 14))
		Game.createMonster("Unpleasant Dream", Position(32209, 32048, 14))
	elseif getBossName() == "Malofur Mangrinder" then
		Game.createMonster("Whirling Blades", Position(32206, 32040, 14))
        Game.createMonster("Whirling Blades", Position(32208, 32040, 14))
		Game.createMonster("Whirling Blades", Position(32205, 32043, 14))
		Game.createMonster("Whirling Blades", Position(32208, 32043, 14))
		Game.createMonster("Whirling Blades", Position(32205, 32045, 14))
		Game.createMonster("Whirling Blades", Position(32206, 32045, 14))
		Game.createMonster("Whirling Blades", Position(32207, 32045, 14))
		Game.createMonster("Whirling Blades", Position(32208, 32045, 14))
		Game.createMonster("Whirling Blades", Position(32209, 32045, 14))
		Game.createMonster("Whirling Blades", Position(32208, 32055, 14))
		Game.createMonster("Whirling Blades", Position(32210, 32055, 14))
		Game.createMonster("Whirling Blades", Position(32205, 32055, 14))
		Game.createMonster("Whirling Blades", Position(32205, 32051, 14))
		Game.createMonster("Whirling Blades", Position(32206, 32051, 14))
		Game.createMonster("Whirling Blades", Position(32207, 32051, 14))
		Game.createMonster("Whirling Blades", Position(32214, 32047, 14))
		Game.createMonster("Whirling Blades", Position(32214, 32045, 14))
		Game.createMonster("Whirling Blades", Position(32214, 32049, 14))		 
		Game.createMonster("Whirling Blades", Position(32200, 32046, 14))	
		Game.createMonster("Whirling Blades", Position(32200, 32049, 14))	
		Game.createMonster("Whirling Blades", Position(32211, 32048, 14))	
		Game.createMonster("Whirling Blades", Position(32211, 32049, 14))	
		Game.createMonster("Whirling Blades", Position(32204, 32047, 14))	
	elseif getBossName() == "Izcandar the Banished" then
		Game.createMonster("The Cold Of Winter", Position(32211, 32044, 14))
		Game.createMonster("The Cold Of Winter", Position(32211, 32048, 14))
		Game.createMonster("The Heat Of Summer", Position(32203, 32048, 14))
		Game.createMonster("The Heat Of Summer", Position(32203, 32044, 14))
	elseif getBossName() == "Plagueroot" then
		Game.createMonster("Plant Attendant", Position(32211, 32044, 14))
		Game.createMonster("Plant Attendant", Position(32211, 32048, 14))
		Game.createMonster("Plant Attendant", Position(32203, 32048, 14))
	end
end

local summonsAlptramun = {
	{name = "Horrible Dream"},
	{name = "Mind-wrecking Dream"},
	{name = "Nightmarish Dream"},
	{name = "Unpleasant Dream"},
}

local summonsIzcandar = {
	{name = "The Cold Of Winter"},
	{name = "The Heat Of Summer"}
}

summonsPlagueroot = {
	{name = "Plant Attendant"}
}

local function keepSummons(bossName, maxCount)
	if hasPlayers() then
		if bossName == "Alptramun" then
			local from = {x=32205,y=32045}
			local to = {x=32209,y=32049}
			local setX = math.random(from.x,to.x)
			local setY = math.random(from.y,to.y)
			local counter = 0
			local monsters = getCustomSpectators(config.centerRoom, false, true, true, true, 14, 14, 14, 14)
			for i = 1, #monsters do
				if monsters[i]:getName():lower() == "horrible dream" or monsters[i]:getName():lower() == "mind-wrecking dream" or monsters[i]:getName():lower() == "nightmarish dream" or monsters[i]:getName():lower() == "unpleasant dream" then
					counter = counter + 1
				end
			end
			if counter <= maxCount then
				local sorted = summonsAlptramun[math.random(#summonsAlptramun)]
				Game.createMonster(sorted.name, {x = setX, y=setY, z = 14})
			end
			addEvent(function()
				keepSummons(bossName, maxCount)
			end, 7000)
		end
		if bossName == "Izcandar the Banished" then
			local from = {x=32205,y=32045}
			local to = {x=32209,y=32049}
			local setX = math.random(from.x,to.x)
			local setY = math.random(from.y,to.y)
			local counter = 0
			local monsters = getCustomSpectators(config.centerRoom, false, true, true, true, 14, 14, 14, 14)
			for i = 1, #monsters do
				if monsters[i]:getName():lower() == "the heat of summer" or monsters[i]:getName():lower() == "the cold of winter" then
					counter = counter + 1
				end
			end
			if counter <= maxCount then
				local sorted = summonsIzcandar[math.random(#summonsIzcandar)]
				Game.createMonster(sorted.name, {x = setX, y=setY, z = 14})
			end
			addEvent(function()
				keepSummons(bossName, maxCount)
			end, 7000)
		end
		if bossName == "Plagueroot" then
			local from = {x=32205,y=32045}
			local to = {x=32209,y=32049}
			local setX = math.random(from.x,to.x)
			local setY = math.random(from.y,to.y)
			local counter = 0
			local monsters = getCustomSpectators(config.centerRoom, false, true, true, true, 14, 14, 14, 14)
			for i = 1, #monsters do
				if monsters[i]:getName():lower() == "plant attendant" or monsters[i]:getName():lower() == "plant abomination" then
					counter = counter + 1
				end
			end
			if counter <= maxCount then
				local sorted = summonsPlagueroot[math.random(#summonsPlagueroot)]
				Game.createMonster(sorted.name, {x = setX, y=setY, z = 14})
			end
			addEvent(function()
				keepSummons(bossName, maxCount)
			end, 7000)
		end
	end
end

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

local dreamcourtsarenabosses = Action()
function dreamcourtsarenabosses.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You or a member in your team have to wait ".. config.timeToFightAgain .."  hours to face ".. getBossName() .." again!")
					return true
				end
				team[#team + 1] = participant
			end
		end

		-- Check if a team currently inside the boss room
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 30, 30, 30, 30)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with ".. getBossName() ..".")
				return true
			end
			spec:remove()
		end

		-- One hour for clean the room
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom)
		Game.createMonster(getBossName(), config.bossPosition)
        spawnSummons()
		if getBossName() == "Alptramun" then
			keepSummons("Alptramun", 4)
		end
		if getBossName() == "Izcandar the Banished" then
			keepSummons("Izcandar the Banished", 3)
		end
		if getBossName() == "Plagueroot" then
			keepSummons("Plagueroot", 2)
		end

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			team[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have ".. config.timeToDefeatBoss .." minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
			-- Assign boss timer
			team[i]:setStorageValue(config.storage, os.time() + config.timeToFightAgain * 60 * 60) -- 20 hours
			item:transform(config.leverId)
			
			addEvent(function()
				local specs, spec = Game.getSpectators(config.centerRoom, false, false, 30, 30, 30, 30)
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

dreamcourtsarenabosses:position({x = 32208, y = 32020, z = 13})
dreamcourtsarenabosses:register()