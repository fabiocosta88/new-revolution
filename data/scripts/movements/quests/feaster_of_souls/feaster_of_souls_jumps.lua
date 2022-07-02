local config = {
    --1 > <
    {position = Position(33570,31467,9), destination = Position(33555,31467,9)},
    {position = Position(33558,31467,9), destination = Position(33572,31467,9)},
    -- 2 > < 
    {position = Position(33549,31440,9), destination = Position(33537,31440,9)},
    {position = Position(33539,31440,9), destination = Position(33551,31438,9)},
    -- 3 > < 
    {position = Position(33540,31411,9), destination = Position(33529,31410,9)},
    {position = Position(33531,31410,9), destination = Position(33542,31411,9)},
    -- 4 /\ \/
    {position = Position(33481,31452,9), destination = Position(33485,31435,8)},
    {position = Position(33484,31435,8), destination = Position(33482,31452,9)},
    -- 5 > <
    {position = Position(33535,31444,8), destination = Position(33545,31444,8)},
    {position = Position(33544,31444,8), destination = Position(33534,31444,8)},
    -- 6 the thaian
    {position = Position(33898,31889,8), destination = Position(33232,31698,7)},
    {position = Position(33813,31906,8), destination = Position(33899,31886,8)},
}

local feaster_of_souls_jumps = MoveEvent()

function feaster_of_souls_jumps.onStepIn(creature, item, position, fromPosition)
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
    feaster_of_souls_jumps:position(value.position)
end
feaster_of_souls_jumps:type("stepin")
feaster_of_souls_jumps:register()