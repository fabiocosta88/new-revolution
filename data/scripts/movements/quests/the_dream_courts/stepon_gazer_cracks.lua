local gazerCracks = MoveEvent()

function gazerCracks.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
    math.randomseed(os.time())
    local choice = math.random(0,1)

    if choice == 0 then 
        player:teleportTo(Position(32652, 32646, 9))
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    else 
        player:teleportTo(Position(32677, 32660, 9))
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end  
end

gazerCracks:type("stepin")
gazerCracks:aid(14902)
gazerCracks:register()