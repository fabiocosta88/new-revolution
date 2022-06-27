local sir_bosses = CreatureEvent("sir_bosses")

local config = {
    pos_rest = Position(33424, 31428, 13),
	pos_fight = Position(33424,31433,13),
	storage_fight = GlobalStorage.GraveDanger.SirBossesFight,
	boss_name = "sir nictros",
	boss_name2 = "sir baeloc",
	centerRoom = Position(33424, 31438, 13),
}

local function getCustomSpectators(position, multifloor, showPlayers, showMonsters, showNPCs, minRangeX, maxRangeX, minRangeY, maxRangeY)
    --getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
    local spectators = Game.getSpectators(position, multifloor, false, minRangeX, maxRangeX, minRangeY, maxRangeY)
    customSpectatorsList = {}
    for _, spectatorCreature in ipairs(spectators) do
        if (showPlayers and spectatorCreature:isPlayer()) or
            (showMonsters and spectatorCreature:isMonster()) or
            (showNPCs and spectatorCreature:isNpc()) then
            table.insert(customSpectatorsList, spectatorCreature)
        end
    end
    return customSpectatorsList
end

local function fillHealth(creature)
	if creature:getHealth() ~= creature:getMaxHealth() then
		creature:addHealth(1000)
		addEvent(function()
			fillHealth(creature)
		end, 500)
	end
end

function sir_bosses.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if attacker:isPlayer() then
        local player = attacker
        local hp = (creature:getHealth()/creature:getMaxHealth())*100
        if hp < 50 then
			if Game.getStorageValue(config.storage_fight) == 1 then
				if creature:getName():lower() == config.boss_name then
					creature:getPosition():sendMagicEffect(CONST_ME_POFF)
					creature:teleportTo(config.pos_rest)
					creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					fillHealth(creature)
					local boss2
					local monsters = getCustomSpectators(config.centerRoom, false, true, true, true, 14, 14, 14, 14)
					for i = 1, #monsters do
						if monsters[i]:getName():lower() == config.boss_name2 then
							boss2 = monsters[i]
						end
					end
					if boss2 then
						boss2:getPosition():sendMagicEffect(CONST_ME_POFF)
						boss2:teleportTo(config.pos_fight)
						boss2:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					end
					Game.setStorageValue(config.storage_fight, 2)
				end
			end
			if Game.getStorageValue(config.storage_fight) == 2 then
				if creature:getName():lower() == config.boss_name2 then
					local boss2
					local monsters = getCustomSpectators(config.centerRoom, false, true, true, true, 14, 14, 14, 14)
					for i = 1, #monsters do
						if monsters[i]:getName():lower() == config.boss_name then
							boss2 = monsters[i]
						end
					end

					if boss2 then
						boss2:getPosition():sendMagicEffect(CONST_ME_POFF)
						boss2:teleportTo(config.pos_fight)
						boss2:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					end
					Game.setStorageValue(config.storage_fight, 3)
				end
			end
		end
    end
    return creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin
end

sir_bosses:register()
