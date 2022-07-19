local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PLANTATTACK)

arr = {
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onTargetTile(creature, pos)
	local min = 1500
	local max = 4000
	local tile = Tile(pos)
	local tileCreatures = tile:getCreatures()
	for i = 0, #tileCreatures do
		local target = tileCreatures[i]
		doTargetCombatHealth(creature, target, COMBAT_EARTHDAMAGE, -min, -max, CONST_ME_CARNIPHILA)
	end
	pos:sendMagicEffect(CONST_ME_PLANTATTACK)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell("instant")


local positions = {
	{pos = Position(32202, 32047, 14)},
	{pos = Position(32207, 32041, 14)},
	{pos = Position(32213, 32048, 14)},
	{pos = Position(32207, 32054, 14)},
}

function spell.onCastSpell(creature, var)
	local sorted = positions[math.random(#positions)]
	creature:teleportTo(sorted)
	combat:execute(creature, var)
	return combat:execute(creature, var)
end

spell:name("plagueroot cross beam")
spell:words("###894")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()