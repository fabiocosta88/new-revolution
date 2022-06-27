local the_fear_feaster_damage = CreatureEvent("the_fear_feaster_damage")

local config = {
    storage_teleported = Storage.FeasterOfSouls.BossTimer.TheFearFeasterTeleported1,
	storage_teleported1 = Storage.FeasterOfSouls.BossTimer.TheFearFeasterTeleported2,
    storage_teleported2 = Storage.FeasterOfSouls.BossTimer.TheFearFeasterTeleported3,
    totem_room = Position(33708, 31470, 15),
    totem_pos = Position(33711, 31470, 15),
    totem_name = "Symbol Of Fear"
}

function the_fear_feaster_damage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if attacker:isPlayer() then
        local player = attacker
        local hp = (creature:getHealth()/creature:getMaxHealth())*100
        if hp < 75 then
            if player:getStorageValue(config.storage_teleported) == 0 then
                player:setStorageValue(config.storage_teleported, 1)
                player:teleportTo(config.totem_room)
                Game.createMonster(config.totem_name, config.totem_pos)
            end
        end
        if hp < 50 then
            if player:getStorageValue(config.storage_teleported1) == 0 then
                player:setStorageValue(config.storage_teleported1, 1)
                player:teleportTo(config.totem_room)
                Game.createMonster(config.totem_name, config.totem_pos)
            end
        end
        if hp < 25 then
            if player:getStorageValue(config.storage_teleported1) == 0 then
                player:setStorageValue(config.storage_teleported1, 1)
                player:teleportTo(config.totem_room)
                Game.createMonster(config.totem_name, config.totem_pos)
            end
        end
    end
    return creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin
end

the_fear_feaster_damage:register()
