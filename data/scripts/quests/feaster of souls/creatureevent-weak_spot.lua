local weak_spot_damage = CreatureEvent("weak_spot_damage")

function searchmonster()
    local centerPosition = Position(33806, 31505, 14)
    local rangeX = 20
    local rangeY = 20
    local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
    local spectator
    
    for i = 1, #spectators do
        spectator = spectators[i]
        if spectator:isMonster() then
            if spectator:getName() == "The Pale worm" then
                return spectator
            end
        end
    end
    return false
end

function weak_spot_damage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    local pale = searchmonster()

    if pale then
        doTargetCombatHealth(attacker, creature, primaryType, -primaryDamage, -primaryDamage, CONST_ME_POFF, ORIGIN_NONE)
        doTargetCombatHealth(attacker, pale, primaryType, -primaryDamage, -primaryDamage, CONST_ME_POFF, ORIGIN_NONE)
        return
    else
        doTargetCombatHealth(attacker, creature, primaryType, -primaryDamage, -primaryDamage, CONST_ME_POFF, ORIGIN_NONE)
    end

    return
end

weak_spot_damage:register()
