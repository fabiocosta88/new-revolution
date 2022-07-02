local the_fear_feaster_damage = CreatureEvent("the_fear_feaster_damage")

local config = {
	storage_teleported = GlobalStorage.TheFearFeaster.Teleported1,
	storage_teleported1 = GlobalStorage.TheFearFeaster.Teleported2,
	storage_teleported2 = GlobalStorage.TheFearFeaster.Teleported3,
    storage_teleported3 = GlobalStorage.TheFearFeaster.Teleported4,
    totem_room = Position(33708, 31470, 15),
    totem_pos = Position(33711, 31470, 15),
    totem_name = "Symbol Of Fear"
}

function the_fear_feaster_damage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if attacker:isPlayer() then
        local player = attacker
        local hp = (creature:getHealth()/creature:getMaxHealth())*100
        if hp < 80 then
            if Game.getStorageValue(config.storage_teleported) == 0 then
                Game.setStorageValue(config.storage_teleported, 1)
                local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
                for i = 1, #specs do
                    spec = specs[i]
                    if spec:isPlayer() then
                        player:teleportTo(config.totem_room)
                    end
                    spec:remove()
                end
                Game.createMonster(config.totem_name, config.totem_pos)
            end
        end
        if hp < 60 then
            if Game.getStorageValue(config.storage_teleported1) == 0 then
                Game.setStorageValue(config.storage_teleported1, 1)
                local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
                for i = 1, #specs do
                    spec = specs[i]
                    if spec:isPlayer() then
                        player:teleportTo(config.totem_room)
                    end
                    spec:remove()
                end
                Game.createMonster(config.totem_name, config.totem_pos)
            end
        end
        if hp < 40 then
            if Game.getStorageValue(config.storage_teleported2) == 0 then
                Game.setStorageValue(config.storage_teleported2, 1)
                local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
                for i = 1, #specs do
                    spec = specs[i]
                    if spec:isPlayer() then
                        player:teleportTo(config.totem_room)
                    end
                    spec:remove()
                end
                Game.createMonster(config.totem_name, config.totem_pos)
            end
        end
        if hp < 20 then
            if Game.getStorageValue(config.storage_teleported3) == 0 then
                Game.setStorageValue(config.storage_teleported3, 1)
                local specs, spec = Game.getSpectators(config.centerRoom, false, false, 14, 14, 13, 13)
                for i = 1, #specs do
                    spec = specs[i]
                    if spec:isPlayer() then
                        player:teleportTo(config.totem_room)
                    end
                    spec:remove()
                end
                Game.createMonster(config.totem_name, config.totem_pos)
            end
        end
    end
    return creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin
end

the_fear_feaster_damage:register()
