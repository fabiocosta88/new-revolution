local alptramunSummonKill = CreatureEvent("alptramunSummonKill")

function alptramunSummonKill.onPrepareDeath(creature)
    if creature:getName():lower() == "horrible dream" then 
        Game.createMonster("Mind-wrecking Dream", creature:getPosition())
        return true
    elseif creature:getName():lower() == "mind-wrecking dream" then 
        Game.createMonster("Nightmarish Dream", creature:getPosition())
        return true
    elseif creature:getName():lower() == "nightmarish dream" then 
        Game.createMonster("unpleasant dream", creature:getPosition())
        return true
    end
    return true
end

alptramunSummonKill:register()