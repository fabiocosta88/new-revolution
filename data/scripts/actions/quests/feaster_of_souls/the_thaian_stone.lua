local config = {
	[32571] = {
		position = Position(33221, 31703, 7),
		destination = Position(33876, 31885, 8),
		action_id = 4603
	},
	[28907] = {
		position = Position(33876, 31886, 8),
		destination = Position(33220, 31703, 7),
		action_id = 4605
	}
}

local the_thain_stone = Action()
function the_thain_stone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local stone = config[item.itemid]

	if not stone then
		return 
	end

	if item.actionid == stone.action_id then
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:teleportTo(stone.destination)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end	
end

for index, value in pairs(config) do
	the_thain_stone:position(value.position)
end
the_thain_stone:register()