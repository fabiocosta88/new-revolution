local red_soul_stealer_walk = MoveEvent()

function red_soul_stealer_walk.onStepIn(creature, item, position, fromPosition)
	local monster = creature:getMonster()
	if not monster or monster:getName():lower() ~= 'red soul stealer' then
		return true
	end
    monster:remove()
    position:sendMagicEffect(CONST_ME_POFF)
    if (Game.getStorageValue(GlobalStorage.TheDreadMaiden.Damage)) > 0 then
        Game.setStorageValue(GlobalStorage.TheDreadMaiden.Damage, Game.getStorageValue(GlobalStorage.TheDreadMaiden.Damage) - 1)
    end
	return true
end

red_soul_stealer_walk:type("stepin")
red_soul_stealer_walk:id(32416)
red_soul_stealer_walk:register()