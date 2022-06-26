local config = {
    --vengoth
    {position = Position(32962,31497,7), destination = Position(33647,31445,10)},
    {position = Position(32963,31497,7), destination = Position(33647,31445,10)},
    --port hope
    {position = Position(32883,32518,7), destination = Position(33615,31415,8)},
    {position = Position(32884,32518,7), destination = Position(33615,31415,8)},
    --jakundaf
    {position = Position(32625,32076,7), destination = Position(31915,32355,8)},
    {position = Position(32626,32076,7), destination = Position(31915,32355,8)},
}

local FoSEntrance = MoveEvent()

function FoSEntrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    for index, value in pairs(config) do
        if creature:getPosition() == value.position then
            player:teleportTo(value.destination)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        end
    end
    return true
end

for index, value in pairs(config) do
    FoSEntrance:position(value.position)
end
FoSEntrance:type("stepin")
FoSEntrance:register()