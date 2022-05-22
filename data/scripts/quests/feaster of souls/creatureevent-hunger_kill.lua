config = {
    monster_name = "Hunger Worm",
    duration = 15 * 10 * 1000
}

local function transformBack(pos, monster, ground)
    local tile = Tile(pos)
    local temp = tile:getGround()
    temp:transform(ground)
    local monster =  Game.createMonster(config.monster_name, pos)   
    return true
end

local hungerWormDeath = CreatureEvent("hungerWormDeath")
function hungerWormDeath.onPrepareDeath(creature)
    local tile = Tile(creature:getPosition())
    local ground = tile:getGround()
    local tmp_holder = ground:getId()
    ground:transform(385)
    addEvent(transformBack, config.duration, creature:getPosition(), config.monster_name, tmp_holder)
    return true
end

hungerWormDeath:register()