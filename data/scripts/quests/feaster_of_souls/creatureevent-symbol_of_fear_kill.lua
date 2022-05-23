local symbolOfFearDeath = CreatureEvent("symbolOfFearDeath")
function symbolOfFearDeath.onPrepareDeath(creature)
    local monster_pos = creature:getPosition()

    local spectators = Game.getSpectators(monster_pos, false, false, 10, 10, 10, 10)
    local spectator
    
    for i = 1, #spectators do
        spectator = spectators[i]
        if spectator:isPlayer() then
            local player = spectator
            player:teleportTo(Position(33711, 31469, 14))
        end
    end
    creature:remove()
end

symbolOfFearDeath:register()