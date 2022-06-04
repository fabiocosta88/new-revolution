local faceless_damage = CreatureEvent("faceless_damage")

function faceless_damage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if Game.getStorageValue(GlobalStorage.FacelessBane.Damage) == 0 then
        doTargetCombatHealth(attacker, creature, primaryType, -primaryDamage, -primaryDamage, CONST_ME_POFF, ORIGIN_NONE)
        doTargetCombatHealth(attacker, creature, secondaryType, -secondaryDamage, -secondaryDamage, CONST_ME_POFF, ORIGIN_NONE)
    else
        return false
    end
    return true
end

local facelessDeath = CreatureEvent("facelessDeath")
function facelessDeath.onPrepareDeath(creature)
    if Game.getStorageValue(GlobalStorage.FacelessBane.Count) == 0 then
        Game.setStorageValue(GlobalStorage.FacelessBane.Count, 3)
        return true
    else
        Game.setStorageValue(GlobalStorage.FacelessBane.Count,  Game.getStorageValue(GlobalStorage.FacelessBane.Count) - 1)
        creature:addHealth(35000)
        Game.createMonster("ripper spectre", creature:getPosition())
        Game.createMonster("gazer spectre", creature:getPosition())
        Game.createMonster("burster spectre", creature:getPosition())
        Game.setStorageValue(GlobalStorage.FacelessBane.Damage, math.random(7, 13))
        return false
    end
    return true
end

facelessDeath:register()
faceless_damage:register()
