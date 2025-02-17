local combat = {}

for i = 25, 75 do
combat[i] = Combat()
combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, i)

local area = createCombatArea(AREA_CIRCLE2X2)
combat[i]:setArea(area)
combat[i]:addCondition(condition)

end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat[math.random(15, 45)]:execute(creature, var)
end

spell:name("barkless skill reducer")
spell:words("###891")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()