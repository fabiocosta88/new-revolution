local brother_worm_damage = CreatureEvent("brother_worm_damage")

function brother_worm_damage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    local unwelcome

    local centerPosition = Position(33708, 31539, 14)
    local rangeX = 20
    local rangeY = 20
    local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
    local spectator
    
    for i = 1, #spectators do
        spectator = spectators[i]
        if spectator:isMonster() then
            if spectator:getName():lower() == "the unwelcome" then
                unwelcome = spectator
            end
        end
    end

    if unwelcome then
        doTargetCombatHealth(attacker, unwelcome, primaryType, -primaryDamage, -primaryDamage, CONST_ME_NONE, ORIGIN_NONE)
        doTargetCombatHealth(attacker, unwelcome, secondaryType, -secondaryDamage, -secondaryDamage, CONST_ME_NONE, ORIGIN_NONE)
    end
    
    doTargetCombatHealth(attacker, creature, primaryType, -primaryDamage, -primaryDamage, CONST_ME_NONE, ORIGIN_NONE)
    doTargetCombatHealth(attacker, creature, secondaryType, -secondaryDamage, -secondaryDamage, CONST_ME_NONE, ORIGIN_NONE)
end

brother_worm_damage:register()
