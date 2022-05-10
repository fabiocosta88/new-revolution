local create_tier_item = TalkAction("/itemtier")
 
function create_tier_item.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	local split = param:split(",")

	local itemType = ItemType(split[1])
	if itemType:getId() == 0 then
		itemType = ItemType(tonumber(split[1]))
		if not tonumber(split[1]) or itemType:getId() == 0 then
			player:sendCancelMessage("There is no item with that id or name.")
			return false
		end
	end

	local count = tonumber(split[2])
	if count then
		if count > 10 then
			player:sendCancelMessage("The tier limit is 10.")
			return false
		end
	end
	
	local result = player:addItem(itemType:getId()):setTier(count)
	if result then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
	return false
end
 
create_tier_item:separator(" ")
create_tier_item:register()