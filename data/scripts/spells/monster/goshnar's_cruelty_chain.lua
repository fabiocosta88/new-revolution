function getCustomSpectators(position, multifloor, showPlayers, showMonsters, showNPCs, minRangeX, maxRangeX, minRangeY, maxRangeY)
    local spectators = Game.getSpectators(position, multifloor, false, minRangeX, maxRangeX, minRangeY, maxRangeY)
    customSpectatorsList = {}
    for _, spectatorCreature in ipairs(spectators) do
        if (showPlayers and spectatorCreature:isPlayer()) or
            (showMonsters and spectatorCreature:isMonster()) or
            (showNPCs and spectatorCreature:isNpc()) then
            table.insert(customSpectatorsList, spectatorCreature)
        end
    end

    return customSpectatorsList
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLUE_ENERGY_SPARK)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local tmpTargets = getCustomSpectators(creature:getPosition(), false, true, false, false, 4, 4, 4, 4)
	local target = Creature(var.number)
	local min = 1000
	local max = 1950
	if not target then return false end
	local creaturePos = creature:getPosition()
	for count, targetInRange in pairs(tmpTargets) do
		doTargetCombatHealth(creature, targetInRange, COMBAT_PHYSICALDAMAGE, -min, -max, CONST_ME_HITAREA)
		local path = creaturePos:getPathTo(tmpTargets[count]:getPosition(), 0, 0, true, true, 8)
		for i=1, #path do
			creaturePos:getNextPosition(path[i], 1)
			creaturePos:sendMagicEffect(CONST_ME_BLUE_ENERGY_SPARK)
		end
	end
	return combat:execute(creature, var)
end

spell:name("goshnar's cruelty chain")
spell:words("###502")
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()