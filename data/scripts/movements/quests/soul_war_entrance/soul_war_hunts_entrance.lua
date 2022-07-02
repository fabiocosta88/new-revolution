local positions = {
    -- Claustrophobic Inferno 
    {position = Position(33615,31422,10), destination = Position(33988,31001,9)},
    -- Rotten Wasteland
    {position = Position(33618,31422,10), destination = Position(33948,31029,11)},
    -- Ebb and Flow
    {position = Position(33621,31422,10), destination = Position(33880,31002,8)},
    -- Furious Crater 
    {position = Position(33624,31422,10), destination = Position(33857,31833,3)},
    -- Mirrored Nightmare 
    {position = Position(33627,31422,10), destination = Position(33888,31185,10)},
}

local soulwarhuntsaccess = MoveEvent()

function soulwarhuntsaccess.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    for index, value in pairs(positions) do
        if creature:getPosition() == value.position then
            player:teleportTo(value.destination)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        end
    end
    return true
end

for index, value in pairs(positions) do
    soulwarhuntsaccess:position(value.position)
end

soulwarhuntsaccess:type("stepin")
soulwarhuntsaccess:register()