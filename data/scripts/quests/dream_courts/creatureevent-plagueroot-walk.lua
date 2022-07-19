local plagueroot_walk_event = MoveEvent()

function plagueroot_walk_event.onStepIn(creature, item, position, fromPosition)
	local monster = creature:getMonster()
	if not monster then
		return true
	end
    if monster:getName():lower() == 'plagueroot' then
        monster:addHealth(10000)
        monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    elseif monster:getName():lower() ~= 'plant attendant' then
        Game.createMonster("Plant Abomination", monster:getPosition())
        monster:remove()
    end
	return true
end

plagueroot_walk_event:type("stepin")
plagueroot_walk_event:id(28951)
plagueroot_walk_event:register()