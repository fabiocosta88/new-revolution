local config = {
	bossName = "The Dread Maiden",
	requiredLevel = 250,
	leverId = 8911,
	timeToFightAgain = 20, -- In hour
	timeToDefeatBoss = 15, -- In minutes
	clearRoomTime = 60, -- In minutes
	daily = true,
	centerRoom = Position(33712, 31503, 14),
	playerPositions = {
		Position(33739, 31506, 14),
		Position(33740, 31506, 14),
		Position(33741, 31506, 14),
		Position(33742, 31506, 14),
		Position(33743, 31506, 14)
	},
	teleportPosition = Position(33711, 31510, 14),
	bossPosition = Position(33712, 31503, 14),
	specPos = Position(33746, 31506, 14),
    storage = Storage.FeasterOfSouls.BossTimer.TheDreadMaiden,
	damage_storage = GlobalStorage.TheDreadMaiden.Damage
}

function spawnGhosts()
	local player
	local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isPlayer() then
			player = spec
			break
		end
	end
	if player then 
		local from = {x=33706,y=31500}
		local to = {x=33717,y=31502}
		local setX = math.random(from.x,to.x)
		local setY = math.random(from.y,to.y)
		local summons = {"Red Soul Stealer", "Blue Soul Stealer", "Green Soul Stealer"}
		local index = math.random(1,3)
		local counter = 0
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isMonster() then
				if spec:getName():lower() == "blue soul stealer" or spec:getName():lower() == "green soul stealer" or spec:getName():lower() == "red soul stealer"  then
					counter = counter + 1
				end
			end
		end
		if counter <= 3 then
			Game.createMonster(summons[index], {x = setX, y=setY, z = 14})
		end
		addEvent(spawnGhosts, 10 * 10000)
	end
end

local dreadmaiden = Action()
function dreadmaiden.onUse(player, item, fromPosition, target, toPosition, isHotkey)
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
		Game.setStorageValue(config.damage_storage, 10)

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
		addEvent(spawnGhosts,  10000)
	end
	return true
end

dreadmaiden:position({x = 33738, y = 31506, z = 14})
dreadmaiden:register()