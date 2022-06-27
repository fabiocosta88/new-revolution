local hungerWormDeath = CreatureEvent("hungerWormDeath")

local function transformBack(pos, monster, ground)
    local tile = Tile(pos)
    local temp = tile:getGround()
    temp:transform(ground)
    local monster =  Game.createMonster(monster, pos)   
    return true
end

function hungerWormDeath.onPrepareDeath(creature)
    local tile = Tile(creature:getPosition())
    local ground = tile:getGround()
    local tmp_holder = ground:getId()
    ground:transform(385)
    addEvent(transformBack, 15 * 10 * 1000, creature:getPosition(), "Hunger Worm", tmp_holder)
    return true
end

hungerWormDeath:register()