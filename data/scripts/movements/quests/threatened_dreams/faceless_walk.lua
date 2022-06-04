local faceless_walk = MoveEvent()

local function transformBack(pos)
    local tile = Tile(pos)
    local temp = tile:getGround()
    temp:setActionId(2077)
    temp:transform(8284)
    return true
end

function faceless_walk.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

    if item:getActionId() == 2077 then
        if Game.getStorageValue(GlobalStorage.FacelessBane.Damage) >  0 then
            local tile = Tile(position)
            local ground = tile:getGround()
            ground:setActionId(2078)
            ground:transform(10180)
            addEvent(transformBack, 10000, position)
            Game.setStorageValue(GlobalStorage.FacelessBane.Damage, Game.getStorageValue(GlobalStorage.FacelessBane.Damage) - 1)
            creature:getPosition():sendMagicEffect(CONST_ME_HOLYDAMAGE)
        else
            creature:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
        end
    end
	return true
end

faceless_walk:type("stepin")
faceless_walk:aid(2077)
faceless_walk:register()