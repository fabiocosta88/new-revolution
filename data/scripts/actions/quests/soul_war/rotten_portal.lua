local config = {
	[33985] = {
		position = Position(33890, 31018, 12),
		destination = Position(33774, 31604, 14),
		action_id = 4608
	},
}

local rotten_portal = Action()
function rotten_portal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local portal = config[item.itemid]

	if not portal then
		return 
	end

	if item.actionid == portal.action_id then
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:teleportTo(portal.destination)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end	
end

for index, value in pairs(config) do
	rotten_portal:position(value.position)
end
rotten_portal:register()