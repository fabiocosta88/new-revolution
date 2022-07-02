local blockbrainhead = MoveEvent()

function blockbrainhead.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	-- Step on floor
	if item.actionid == 4063 then
        player:teleportTo(fromPosition)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
	return true
end

blockbrainhead:type("stepin")
blockbrainhead:aid(4063)

blockbrainhead:register()