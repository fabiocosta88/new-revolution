local config = {
    [37109] = {changeTo = 20}
}

local sliverConverter = Action()

function getForgeDusts(player) 
    if not player then
        return false
    end
    local resultId = db.storeQuery("SELECT `forge_dusts` FROM `players` WHERE `id` = " .. player:getGuid())
	if resultId ~= false then
		local dusts = result.getDataInt(resultId, "forge_dusts")
		result.free(resultId)
		return dusts
	end   
end 

function addForgeDust(player,ammount)
    if not player or ammount then
        return false
    end
    local dusts = getForgeDusts(player)
    if dusts then
        local new_total = dusts + ammount
        db.query("UPDATE `players` set `forge_dusts` = " .. new_total .. " WHERE id = " .. player:getGuid())
        return true
    end
end

function sliverConverter.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local slivers = config[target.itemid]
 
    if not slivers then
        return false
    end
 
    local charges = item:getCharges()
    if slivers.changeTo then
        player:sendTextMessage(MESSAGE_STATUS, "Added 20 dusts in your forge.")
        target:remove(1)
        addForgeDust(player, slivers.changeTo)
        item:transform(item:getId(), charges -1)
    end
    if charges == 0 then
        item:remove()
    end
    return true
end

sliverConverter:id(23722)
sliverConverter:register()
