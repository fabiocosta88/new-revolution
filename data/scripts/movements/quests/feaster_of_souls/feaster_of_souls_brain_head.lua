local config = {
    boss_name = "Brain Head",
    action_id_entrance = 4601,
    minion_name = "Cerebellum",
    destination = Position(31963, 32325, 10),
    boss_pos = Position(31954, 32325, 10),
    minion_pos = {
        Position(31960, 32320, 10),
        Position(31961, 32331, 10),
        Position(31955, 32326, 10),
        Position(31955, 32324, 10),
        Position(31953, 32324, 10),
        Position(31953, 32326, 10),
        Position(31945, 32320, 10),
        Position(31945, 32331, 10),
    },
    requiredLevel = 250,
    timeToFightAgain = 20, -- In hour
    timeToDefeatBoss = 10, -- In minutes
    clearRoomTime = 10, -- In minutes
    daily = true,
    centerRoom = Position(31954, 32325, 10),
    leavePos = Position(31972, 32326, 10),
    radius_center = 13,
    storage = Storage.FeasterOfSouls.BossTimer.BrainDead
}

local FOSbrain_head = MoveEvent()

function FOSbrain_head.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()

	if not player then
		return
	end

    if item.actionid == config.action_id_entrance then
        if player:getLevel() < config.requiredLevel then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to be level ".. teleport.requiredLevel .." or higher to face " .. teleport.boss_name .. ".")
            return true
        end

        if config.daily and player:getStorageValue(config.storage) > os.time() then
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            player:teleportTo(fromPosition)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait ".. config.timeToFightAgain .."  hours to face ".. config.boss_name .." again!")
            return true
        end

        local specs, spec = Game.getSpectators(config.centerRoom, false, false, config.radius_center, config.radius_center, config.radius_center, config.radius_center)
        local counter = 0
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                counter = counter + 1
                if counter >= 5 then
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There are already 5 players fighting with the ".. teleport.name ..".")
                    player:teleportTo(fromPosition)
                    player:getPosition():sendMagicEffect(CONST_ME_POFF)
                    return true
                end
            end
            spec:remove()
        end

        addEvent(clearRoom, config.clearRoomTime * 60 * 1000, config.centerRoom)

        Game.createMonster(config.boss_name, config.boss_pos)
        for index, minion in pairs(config.minion_pos) do
            Game.createMonster(config.minion_name, minion)
        end

        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:teleportTo(config.destination)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have ".. config.timeToDefeatBoss .." minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
        player:setStorageValue(config.storage, os.time() + config.timeToFightAgain * 60 * 60) -- 20 hours
       
        addEvent(function()
            local specs, spec = Game.getSpectators(config.centerRoom, false, false, config.radius_center, config.radius_center, config.radius_center, config.radius_center)
                for i = 1, #specs do
                    spec = specs[i]
                    if spec:isPlayer() then
                        spec:teleportTo(config.leavePos)
                        spec:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                        spec:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
                    end
                end
        end, config.timeToDefeatBoss * 60 * 1000)
    end
end

FOSbrain_head:type("stepin")
FOSbrain_head:aid(4601)
FOSbrain_head:register()