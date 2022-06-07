config = {
	miniBossName1 = "the red knight",
	miniBossName2 = "nargol the impaler",
	miniBossName3 = "magnor mournbringer",
	miniBossName4 = "rewar the bloody"
}

local GDMiniDeath = CreatureEvent("GDMiniDeath")
function GDMiniDeath.onPrepareDeath(creature)
    if creature:getName():lower() == config.miniBossName1 or creature:getName():lower() == config.miniBossName2 or creature:getName():lower() == config.miniBossName3 or creature:getName():lower() == config.miniBossName4 then
        Game.setStorageValue(GlobalStorage.KingZelos.Minibosses,  Game.getStorageValue(GlobalStorage.KingZelos.Minibosses) + 1)
    end  
	return true
end

GDMiniDeath:register()