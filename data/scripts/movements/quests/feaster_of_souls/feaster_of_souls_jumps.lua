local positions = {
    --1 > <
    {position = {x = 33570, y = 31467, z = 9}, destination = {x = 33555, y = 31467, z = 9}},
    {position = {x = 33558, y = 31467, z = 9}, destination = {x = 33572, y = 31467, z = 9}},
    -- 2 > < 
    {position = {x = 33549, y = 31440, z = 9}, destination = {x = 33537, y = 31440, z = 9}},
    {position = {x = 33539, y = 31440, z = 9}, destination = {x = 33551, y = 31438, z = 9}},
    -- 3 > < 
    {position = {x = 33540, y = 31411, z = 9}, destination = {x = 33529, y = 31410, z = 9}},
    {position = {x = 33531, y = 31410, z = 9}, destination = {x = 33542, y = 31411, z = 9}},
    -- 4 /\ \/
    {position = {x = 33481, y = 31452, z = 9}, destination = {x = 33485, y = 31435, z = 8}},
    {position = {x = 33484, y = 31435, z = 8}, destination = {x = 33482, y = 31452, z = 9}},
    -- 5 > <
    {position = {x = 33535, y = 31444, z = 8}, destination = {x = 33545, y = 31444, z = 8}},
    {position = {x = 33544, y = 31444, z = 8}, destination = {x = 33534, y = 31444, z = 8}},
    -- 6 the thaian
    {position = {x = 33898, y = 31889, z = 8}, destination = {x = 33232, y = 31698, z = 7}},
    {position = {x = 33813, y = 31906, z = 8}, destination = {x = 33899, y = 31886, z = 8}},
}

local feaster_of_souls_jumps = MoveEvent()

function feaster_of_souls_jumps.onStepIn(creature, item, position, fromPosition)
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
    feaster_of_souls_jumps:position(value.position)
end

feaster_of_souls_jumps:register()