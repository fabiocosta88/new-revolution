local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

local combat6 = Combat()
combat6:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat6:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)


arr = {
	{0, 0, 0, 0, 0},
	{0, 1, 0, 1, 0},
	{0, 0, 2, 0, 0},
	{0, 1, 0, 1, 0},
	{0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
combat:setArea(area)

arr1 = {
	{0, 0, 0, 0, 0},
	{0, 0, 1, 0, 0},
	{0, 1, 2, 1, 0},
	{0, 0, 1, 0, 0},
	{0, 0, 0, 0, 0},
}

local area1 = createCombatArea(arr1)
combat1:setArea(area1)

arr2 = {
	{0, 1, 1, 1, 0},
	{1, 0, 0, 0, 1},
	{1, 0, 2, 0, 1},
	{1, 0, 0, 0, 1},
	{0, 1, 1, 1, 0},
}

local area2 = createCombatArea(arr2)
combat2:setArea(area2)

arr4 = {
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 0, 0, 0, 1, 0},
	{1, 0, 0, 0, 0, 0, 1},
	{1, 0, 0, 2, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 1},
	{0, 1, 0, 0, 0, 1, 0},
	{0, 0, 1, 1, 1, 0, 0},
}

local area4 = createCombatArea(arr4)
combat4:setArea(area4)

arr6 = {
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 0, 0, 0, 0, 0, 1, 0},
	{1, 0, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 2, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 0, 0, 1},
	{1, 0, 0, 0, 0, 0, 0, 0, 1},
	{0, 1, 0, 0, 0, 0, 0, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 0, 0},
}

local area6 = createCombatArea(arr6)
combat6:setArea(area6)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	combat:execute(creature,var)
	addEvent(function()
		combat1:execute(creature,var)
	end, 500)
	addEvent(function()
		combat2:execute(creature,var)
	end, 1000)
	addEvent(function()
		combat4:execute(creature,var)
	end, 2000)
	addEvent(function()
		combat6:execute(creature,var)
	end, 3000)
	return true
end

spell:name("king zelos death wave")
spell:words("###888")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()