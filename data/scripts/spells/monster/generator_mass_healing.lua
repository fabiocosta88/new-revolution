local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)

local monsters = {
	"maxxenius",
	"generator"
}

local damageValue = math.random(600, 1500)

function onTargetTile(creature, pos)
	local tile = Tile(pos)
	if tile then
		local target = tile:getTopCreature()
		if target and target ~= creature then
			if table.contains(monsters, target:getName():lower()) then
				target:addHealth(damageValue)
			else
				doTargetCombatHealth(creature:getId(), target, COMBAT_ENERGYDAMAGE, -600, -1500, CONST_ME_ENERGYAREA)
			end
		end
	end
	return true
end

combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	creature:addHealth(damageValue) -- otherwise minotaur cult didnt heal itself, only allies
	return combat:execute(creature, variant)
end

spell:name("Generator Mass Healing")
spell:words("##852")
spell:blockWalls(true)
spell:needLearn(true)
spell:isAggressive(false)
spell:register()
