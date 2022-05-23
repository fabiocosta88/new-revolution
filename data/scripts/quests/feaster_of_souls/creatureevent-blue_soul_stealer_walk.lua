local blue_soul_stealer_walk = MoveEvent()

function blue_soul_stealer_walk.onStepIn(creature, item, position, fromPosition)
	local monster = creature:getMonster()
	if not monster or monster:getName():lower() ~= 'blue soul stealer' then
		return true
	end
    monster:remove()
    position:sendMagicEffect(CONST_ME_POFF)
    if (Game.getStorageValue(GlobalStorage.TheDreadMaiden.Damage)) > 0 then
        Game.setStorageValue(GlobalStorage.TheDreadMaiden.Damage, Game.getStorageValue(GlobalStorage.TheDreadMaiden.Damage) - 1)
    end
	return true
end

blue_soul_stealer_walk:type("stepin")
blue_soul_stealer_walk:id(32414)
blue_soul_stealer_walk:register()