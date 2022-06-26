local positions = {
    -- Goshnar's Malice
    {position = Position(33999,31078,11), destination = Position(33685,31599,14)},
    -- Goshnar's Hatred
    {position = Position(33890,31018,12), destination = Position(33780,31601,14)},
    -- Goshnar's Spite
    {position = Position(33936,31092,8), destination = Position(33781,31634,14)},
    -- Goshnar's Cruelty
    -- tp one
    {position = Position(33888,31874,3), destination = Position(33831,31881,4)},
    -- tp two
    {position = Position(33828,31881,4), destination = Position(33837,31867,5)},
    -- tp three
    {position = Position(33856,31885,5), destination = Position(33865,31864,6)},
    -- Mirrored Nightmare 
    {position = Position(33937,31217,11), destination = Position(33782,31665,14)},
}

local soulwarbossentrance = MoveEvent()

function soulwarbossentrance.onStepIn(creature, item, position, fromPosition)
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
    soulwarbossentrance:position(value.position)
end

soulwarbossentrance:type("stepin")
soulwarbossentrance:register()