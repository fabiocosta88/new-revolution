local config = {
    [3031] = {changeTo = 3035},
    [3035]  = {changeBack = 3031, changeTo = 3043},
    [3043] = {changeBack = 3035}
}

local goldChange = Action()

function goldChange.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    local coin = config[item.itemid]
	
    if not coin then
        return false
    end

    if coin.changeTo and item.type == 100 then
        item:remove()
        player:addItem(coin.changeTo, 1)
    elseif coin.changeBack then
        item:transform(item.itemid, item.type - 1)
        player:addItem(coin.changeBack, 100)
    else
        return false
    end
    return true
end

goldChange:id(3031, 3035, 3043)
goldChange:register()