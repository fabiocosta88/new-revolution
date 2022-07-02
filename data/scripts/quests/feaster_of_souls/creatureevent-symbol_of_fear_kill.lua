local symbolOfFearDeath = CreatureEvent("symbolOfFearDeath")

function symbolOfFearDeath.onPrepareDeath(creature)
    local monster_pos = creature:getPosition()
    local specs, spec = Game.getSpectators(monster_pos, false, false, 14, 14, 13, 13)
    for i = 1, #specs do
        spec = specs[i]
        if spec:isPlayer() then
            player:teleportTo(Position(33711, 31469, 14))
        end
        spec:remove()
    end
    return true
end

symbolOfFearDeath:register()