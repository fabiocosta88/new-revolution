local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setArea(createCombatArea(AREA_BEAM7))

function onTargetTile(creature, pos)
	local min = 700
	local max = 2000
	local tile = Tile(pos)
	local tileCreatures = tile:getCreatures()
	for i = 1, #tileCreatures do
		local target = tileCreatures[i]
		if target:isMonster() and target:getName():lower() == "horrible dream" or target:getName():lower() == "mind-wrecking dream" or target:getName():lower() == "nightmarish dream" or target:getName():lower() == "unpleasant dream" then
			doTargetCombatHealth(creature, creature, COMBAT_HEALING, min, max, CONST_ME_DEATHAREA)
		else
			doTargetCombatHealth(creature, target, COMBAT_DEATHDAMAGE, -min, -max, CONST_ME_DEATHAREA)
		end
	end
	pos:sendMagicEffect(CONST_ME_MORTAREA)
	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("alptramun death beam")
spell:words("###892")
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()