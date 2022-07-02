local paleWormKill = CreatureEvent("paleWormKill")

function paleWormKill.onPrepareDeath(creature)
    Game.setStorageValue(GlobalStorage.ThePaleWorm.Battle, 0)
    return true
end

paleWormKill:register()