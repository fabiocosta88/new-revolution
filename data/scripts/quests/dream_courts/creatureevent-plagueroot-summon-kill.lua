local plaguerootSummonKill = CreatureEvent("plaguerootSummonKill")

function plaguerootSummonKill.onPrepareDeath(creature)
	local monster = creature:getMonster()
	if not monster then
		return true
	end
    if monster:getName():lower() == "plant abomination" then
        Game.createMonster("Plant Attendant", monster:getPosition())
    elseif monster:getName():lower() == "Plant Attendant" then
        Game.createMonster("Plant Attendant", monster:getPosition())
    end
    return true
end

plaguerootSummonKill:register()