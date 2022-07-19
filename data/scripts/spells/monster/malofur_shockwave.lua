local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onTargetTile(creature, pos)
	local min = 2000
	local max = 4500
	local tile = Tile(pos)
	local tileCreatures = tile:getCreatures()
	for i = 1, #tileCreatures do
		local target = tileCreatures[i]
		doTargetCombatHealth(creature, target, COMBAT_PHYSICALDAMAGE, -min, -max, CONST_ME_DRAWBLOOD)
	end
	pos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell("instant")

local function delayedCastSpell(cid, var)
	local creature = Creature(cid)
	if not creature then
		return
	end
	creature:say("BOOOOOM!", TALKTYPE_ORANGE_2)
	return combat:execute(creature, positionToVariant(creature:getPosition()))
end

function spell.onCastSpell(creature, var)
	creature:say("RAAAARGH! I'M MASHING YE TO DUST BOOM!", TALKTYPE_ORANGE_2)
	addEvent(delayedCastSpell, 5000, creature:getId(), var)
	return true
end

spell:name("malofur shockwave")
spell:words("###893")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()