
local config = {
	[14888] = Position(32208, 32093, 13),
	[14889] = Position(32214, 32048, 14)
}

local courts_entrance = Action()

function courts_entrance.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

    player:getPosition():sendMagicEffect(CONST_ME_POFF)
    player:teleportTo(targetPosition)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

courts_entrance:aid(14888, 14889)
courts_entrance:register()
