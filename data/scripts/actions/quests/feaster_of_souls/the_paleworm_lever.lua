local config = {
	bossName = "The Pale worm",
	bossName2 = "A Weak Spot",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 15, -- In minutes
	clearRoomTime = 60, -- In minutes
	daily = true,
	centerRoom = Position(33805, 31504, 14),
	centerRoom2 = Position(33805, 31504, 15),
	playerPositions = {
		Position(33772, 31504, 14),
		Position(33773, 31504, 14),
		Position(33774, 31504, 14),
		Position(33775, 31504, 14),
		Position(33773, 31503, 14),
		Position(33774, 31503, 14),
		Position(33775, 31503, 14),
		Position(33773, 31505, 14),
		Position(33774, 31505, 14),
		Position(33775, 31505, 14)
	},
	teleportPosition = Position(33808, 31515, 14),
	bossPosition = Position(33805, 31504, 14),
	specPos = Position(33779, 31504, 14),
    storage = Storage.FeasterOfSouls.BossTimer.ThePaleWorm,
	storage_summon = Storage.FeasterOfSouls.BossTimer.ThePaleWormSummon,
	storage_damage = Storage.FeasterOfSouls.BossTimer.ThePaleWormDamage,
	boss_2_pos = Position(33805, 31505, 15)
}


function hasPlayers()
	local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isPlayer() then
			return spec
		end
	end
	return false
end

function hasPlayersDown()
	local specs, spec = Game.getSpectators(config.centerRoom2, false, false, 14, 14, 13, 13)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isPlayer() then
			return spec
		end
	end
	return false
end

function countMonster()
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

function countMonster2()
    local counter = 0
	local specs, spec = Game.getSpectators(config.centerRoom2, false, false, 14, 14, 13, 13)
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

function getPaleWorm()
	local specs, spec = Game.getSpectators(config.centerRoom2, false, false, 14, 14, 13, 13)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isMonster() then
			if spec:getName():lower() == "the pale worm" then
                return spec
			end
		end
	end
	return false
end

function damagePlayers()
	local pale = getPaleWorm()
	if pale then
		local damage = 100
		local specs, spec = Game.getSpectators(config.centerRoom2, false, false, 14, 14, 13, 13)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				if spec:getStorageValue(config.storage_damage) == 1 then
					doTargetCombatHealth(pale, spec, COMBAT_PHYSICALDAMAGE, -damage, -damage, CONST_ME_POFF, ORIGIN_NONE)
					damage = damage + 100
				end
			end
		end
		addEvent(damagePlayers, 3 * 1000)
	end
end

function spawnGreedWormUp()
	local player = hasPlayers()
	if player then 
		if player:getStorageValue(config.storage_summon) == 1 then
			local from = {x=33799,y=31499}
			local to = {x=33811,y=31503}
			local setX = math.random(from.x,to.x)
			local setY = math.random(from.y,to.y)
			local counter = countMonster()
			if counter <= 5 then
				Game.createMonster("Greed Worm", {x = setX, y=setY, z = 14})
			end
		end
	end
	local player2 = hasPlayersDown()
	if player2 then
		if player2:getStorageValue(config.storage_summon) == 1 then
			local from = {x=33799,y=31499}
			local to = {x=33811,y=31503}
			local setX = math.random(from.x,to.x)
			local setY = math.random(from.y,to.y)
			local counter2 = countMonster2()
			if counter2 <= 5 then
				Game.createMonster("Greed Worm", {x = setX, y=setY, z = 15})
			end
		end
	end
	if player or player2 then
		addEvent(spawnGreedWormUp, 10 * 1000)
	end
end

local paleworm = Action()
function paleworm.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
		local specs2, spec2 = Game.getSpectators(config.centerRoom2, false, false, 14, 14, 13, 13)
		for i = 1, #specs2 do
			spec2 = specs2[i]
			if spec2:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with ".. config.bossName ..".")
				return true
			end
			spec2:remove()
		end

		-- One hour for clean the room
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom)
		addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom2)
		Game.createMonster(config.bossName, config.bossPosition)
		Game.createMonster(config.bossName2, config.boss_2_pos)

		-- Teleport team participants
		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			team[i]:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have ".. config.timeToDefeatBoss .." minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
			-- Assign boss timer
			team[i]:setStorageValue(config.storage, os.time() + config.timeToFightAgain * 60 * 60) -- 20 hours
			item:transform(config.leverId)
			--set storage summon and damage
			team[i]:setStorageValue(config.storage_summon, 1) 
			team[i]:setStorageValue(config.storage_damage, 1) 
			addEvent(function()
				team[i]:setStorageValue(config.storage_summon, 0) 
				team[i]:setStorageValue(config.storage_damage, 0) 
			end, config.timeToDefeatBoss * 60 * 1000)
			
			addEvent(function()
				local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
				for i = 1, #specs do
					spec = specs[i]
						if spec:isPlayer() then
							spec:teleportTo(config.specPos)
							spec:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
							spec:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
							spec:setStorageValue(config.storage_summon, 0) 
							spec:setStorageValue(config.storage_damage, 0) 
						end
					end
				end, config.timeToDefeatBoss * 60 * 1000)
			addEvent(function()
				local specs2, spec2 = Game.getSpectators(config.centerRoom2, false, false, 14, 14, 13, 13)
					for i = 1, #specs2 do
						spec2 = specs2[i]
						if spec2:isPlayer() then
							spec2:teleportTo(config.specPos)
							spec2:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
							spec2:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
							spec2:setStorageValue(config.storage_summon, 0) 
							spec2:setStorageValue(config.storage_damage, 0) 
						end
					end
				end, config.timeToDefeatBoss * 60 * 1000)
		end
		addEvent(function()
			Game.createMonster("Hunger Worm", Position({x = 33802, y = 31500, z = 14}), false, true)
		end, 30000)
		addEvent(spawnGreedWormUp, 30000)
		addEvent(damagePlayers,  45000)
	end
	return true
end

paleworm:position({x = 33771, y = 31504, z = 14})
paleworm:register()