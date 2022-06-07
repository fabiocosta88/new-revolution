local config = {
    tp_action = 5088,
    position = Position(33443,31537,13)
}

local king_zelos_entrance = MoveEvent()

function king_zelos_entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    
    if item.actionid == config.tp_action then
        if Game.getStorageValue(GlobalStorage.KingZelos.Minibosses) == 4 then
            player:teleportTo(config.position)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to kill the 4 minibosses to face King Zelos!")
            player:teleportTo(fromPosition)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    end
    return true
end

king_zelos_entrance:type("stepin")
king_zelos_entrance:aid(config.tp_action)
king_zelos_entrance:register()