local dread_maiden_damage = CreatureEvent("dread_maiden_damage")

function dread_maiden_damage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if attacker:isPlayer() then 
        local player = attacker

        local divisor = Game.getStorageValue(GlobalStorage.TheDreadMaiden.Damage)

        if divisor == 0 then
            doTargetCombatHealth(attacker, creature, primaryType, -primaryDamage, -primaryDamage, CONST_ME_NONE, ORIGIN_NONE)
            doTargetCombatHealth(attacker, creature, secondaryType, -secondaryDamage, -secondaryDamage, CONST_ME_NONE, ORIGIN_NONE)
        else
            local damage_primary = primaryDamage / divisor
            local damage_secondary = secondaryDamage / divisor
    
            doTargetCombatHealth(attacker, creature, primaryType, -damage_primary, -damage_primary, CONST_ME_NONE, ORIGIN_NONE)
            doTargetCombatHealth(attacker, creature, secondaryType, -damage_secondary, -damage_secondary, CONST_ME_NONE, ORIGIN_NONE)
        end


    end    
end

dread_maiden_damage:register()
