local config = {
	[23538] = {mountId = 94, message = "You receive the permission to ride a sparkion"},
	[23684] = {mountId = 98, message = "You receive the permission to ride a neon sparkid"},
	[23685] = {mountId = 99, message = "You receive the permission to ride a vortexion"},
	[32629] = {mountId = 162, message = "You are now versed to ride the haze"},
}

local heartDestructionEggs = Action()

function heartDestructionEggs.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local mount = config[item.itemid]

	if not mount then
		return true
	end

	if not player:hasMount(mount.mountId) then
		player:addMount(mount.mountId)
		player:say(mount.message, TALKTYPE_MONSTER_SAY)
		item:remove(1)
		if item.itemid == 32629 then
			player:addAchievement('Nothing but Hot Air')
		end
		if item.itemid == 23538 or item.itemid == 23684 or item.itemid == 23685 then
			if player:hasMount(94) and player:hasMount(98) and player:hasMount(99) then
				player:addAchievement('Vortex Tamer')
			end
		end
	else
		player:sendTextMessage(19, "You already have this mount")
	end
	return true
end


for itemId, info in pairs(config) do
	heartDestructionEggs:id(itemId)
end

heartDestructionEggs:register()
