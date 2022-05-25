local miniboses = {
    [4604] = {
        name = "Vok The Freakish",
        portal_loc = Position(33509, 31450, 9),
        destination = Position(33508, 31485, 9),
        bossPos = Position(33508, 31495, 9),
        leavePos = Position(33509, 31451, 9),
        requiredLevel = 250,
        timeToFightAgain = 20, -- In hour
        timeToDefeatBoss = 10, -- In minutes
        clearRoomTime = 10, -- In minutes
        daily = true,
        centerRoom = Position(33508, 31490, 9),
        radius_center = 8,
        storage = Storage.FeasterOfSouls.BossTimer.VokTheFreakish
    },
    [4602] = {
        name = "Irgix The Flimsy",
        portal_loc = Position(33566, 31475, 8),
        destination = Position(33467, 31397, 8),
        bossPos = Position(33468, 31407, 8),
        leavePos = Position(33491, 31399, 8),
        requiredLevel = 250,
        timeToFightAgain = 20, -- In hour
        timeToDefeatBoss = 10, -- In minutes
        clearRoomTime = 10, -- In minutes
        daily = true,
        centerRoom = Position(33467, 31401, 8),
        radius_center = 8,
        storage = Storage.FeasterOfSouls.BossTimer.IrgixTheFlimsy
    },
    [4600] = {
        name = "Unaz The Mean",
        portal_loc = Position(33566, 31475, 8),
        destination = Position(33562, 31493, 8),
        bossPos = Position(33579, 31491, 8),
        leavePos = Position(33566, 31476, 8),
        requiredLevel = 250,
        timeToFightAgain = 20, -- In hour
        timeToDefeatBoss = 10, -- In minutes
        clearRoomTime = 10, -- In minutes
        daily = true,
        centerRoom = Position(33569, 31497, 8),
        radius_center = 12,
        storage = Storage.FeasterOfSouls.BossTimer.UnaztheMean
    }
}

local FOSminis = MoveEvent()

function FOSminis.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()

	if not player then
		return
	end

    local teleport = miniboses[item.actionid]

    if not teleport then
        return
    end

    if player:getLevel() < teleport.requiredLevel then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to be level ".. teleport.requiredLevel .." or higher to face " .. teleport.name .. ".")
        return true
    end

    if teleport.daily and player:getStorageValue(teleport.storage) > os.time() then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:teleportTo(fromPosition)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait ".. teleport.timeToFightAgain .."  hours to face ".. teleport.name .." again!")
        return true
    end

    local specs, spec = Game.getSpectators(teleport.centerRoom, false, false, teleport.radius_center, teleport.radius_center, teleport.radius_center, teleport.radius_center)
    for i = 1, #specs do
        spec = specs[i]
        if spec:isPlayer() then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with ".. teleport.name ..".")
            return true
        end
        spec:remove()
    end

    addEvent(clearRoom, teleport.clearRoomTime * 60 * 1000, teleport.centerRoom)

    Game.createMonster(teleport.name, teleport.bossPos)

    player:getPosition():sendMagicEffect(CONST_ME_POFF)
    player:teleportTo(teleport.destination)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have ".. teleport.timeToDefeatBoss .." minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
    player:setStorageValue(teleport.storage, os.time() + teleport.timeToFightAgain * 60 * 60) -- 20 hours

    addEvent(function()
        local specs, spec = Game.getSpectators(teleport.centerRoom, false, false, teleport.radius_center, teleport.radius_center, teleport.radius_center, teleport.radius_center)
            for i = 1, #specs do
                spec = specs[i]
                if spec:isPlayer() then
                    spec:teleportTo(teleport.leavePos)
                    spec:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                    spec:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
                end
            end
    end, teleport.timeToDefeatBoss * 60 * 1000)
end

FOSminis:type("stepin")
for index, value in pairs(miniboses) do
	FOSminis:aid(index)
end
FOSminis:register()