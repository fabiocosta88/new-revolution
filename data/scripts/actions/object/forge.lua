local forge = Action()

function forge.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:openForge()
	return true
end

forge:id(37122)
forge:register()
