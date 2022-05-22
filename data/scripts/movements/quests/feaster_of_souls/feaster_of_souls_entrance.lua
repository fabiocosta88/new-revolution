local positions = {
    --vengoth
    {position = {x = 32962, y = 31497, z = 7}, destination = {x = 33647, y = 31445, z = 10}},
    {position = {x = 32963, y = 31497, z = 7}, destination = {x = 33647, y = 31445, z = 10}},
    --port hope
    {position = {x = 32883, y = 32518, z = 7}, destination = {x = 33615, y = 31415, z = 8}},
    {position = {x = 32884, y = 32518, z = 7}, destination = {x = 33615, y = 31415, z = 8}},
    --jakundaf
    {position = {x = 32625, y = 32076, z = 7}, destination = {x = 31915, y = 32355, z = 8}},
    {position = {x = 32626, y = 32076, z = 7}, destination = {x = 31915, y = 32355, z = 8}}
}

local bossTeleport = MoveEvent()

function bossTeleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    for index, value in pairs(positions) do
        if Tile(position) == Tile(value.position) then
            player:teleportTo(value.destination)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        end
    end
    return true
end

for index, value in pairs(positions) do
    bossTeleport:position(value.position)
end

bossTeleport:register()