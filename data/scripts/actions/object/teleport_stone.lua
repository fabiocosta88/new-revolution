local teleport_stone = Action("Teleport_Stone")

local first_option = {
    [1] = {name = "Cities"},
    [2] = {name = "House"},
	[3] = {name = "Guild House"}
}

local cities = {
    [1] = {name = "Ab'Dendriel", positions = {x = 32732, y = 31634, z = 7}},
    [2] = {name = "Ankrahmun", positions = {x = 33195, y = 32853, z = 8}},
	[3] = {name = "Carlin", positions = {x = 32360, y = 31782, z = 7}},
	[4] = {name = "Darashia", positions = {x = 33213, y = 32454, z = 1}},
	[5] = {name = "Edron", positions = {x = 33217, y = 31814, z = 8}},
	[6] = {name = "Farmine", positions = {x = 33023, y = 31521, z = 11}},
	[7] = {name = "Feyrist", positions = {x = 33484, y = 32237, z = 7}},
	[8] = {name = "Gray Island", positions = {x = 33448, y = 31322, z = 9}},
	[9] = {name = "Issavi", positions = {x = 33921, y = 31477, z = 5}},
	[10] = {name = "Kazordoon", positions = {x = 32649, y = 31925, z = 11}},
	[11] = {name = "Krailos", positions = {x = 33657, y = 31665, z = 8}},
	[12] = {name = "Liberty Bay", positions = {x = 32317, y = 32826, z = 7}},
	[13] = {name = "Port Hope" , positions = {x =32595, y = 32745, z = 7}},
	[14] = {name = "Rathleton", positions = {x = 33594, y = 31899, z = 6}},
	[15] = {name = "Roshamuul", positions = {x = 33513, y = 32363, z = 6}},
	[16] = {name = "Svargrond", positions = {x = 32212, y = 31132, z = 7}},
	[17] = {name = "Thais", positions = {x = 32369, y = 32241, z = 7}},
	[18] = {name = "Venore", positions = {x = 32957, y = 32076, z = 7}},
	[19] = {name = "Yalahar", positions = {x = 32787, y = 31276, z = 7}}
}

function teleport_stone.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) == false and getCreatureCondition(player, CONDITION_INFIGHT) == true then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You cannot use this item in battle.')
        return true
    end
	if not player:isPremium() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You are not VIP to use this item.')
        return true
	end	
    player:registerEvent("ModalWindow_Teleport_Stone")
 
    local title = "Vip Teleport Stone"
    local message = "Para onde voce deseja ir?"
	local playerGuild = player:getGuild()
 
    local window = ModalWindow(1001, title, message)
 
    window:addButton(101, "Cancel")
	window:addButton(100, "Confirm")
 
    window:addChoice(1, "Cities")
    window:addChoice(2, "House")
	window:addChoice(3, "Guild House")

    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
 
    window:sendToPlayer(player)
    return true
end

teleport_stone:id(35910)
teleport_stone:register()

local modalTp = CreatureEvent("ModalWindow_Teleport_Cities")
modalTp:type("modalwindow")

function modalTp.onModalWindow(player, modalWindowId, buttonId, choiceId)
    player:unregisterEvent("ModalWindow_Teleport_Cities")
    if modalWindowId == 1000 then
        if buttonId == 100 then
            player:getPosition():sendMagicEffect(CONST_ME_SMOKE)
            player:teleportTo(cities[choiceId].positions)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Teleported to '.. cities[choiceId].name ..'.')
        end
    end
    return true
end

modalTp:register()

local modalTpCities = CreatureEvent("ModalWindow_Teleport_Stone")
modalTpCities:type("modalwindow")

function modalTpCities.onModalWindow(player, modalWindowId, buttonId, choiceId)
	player:unregisterEvent("ModalWindow_Teleport_Stone")
	if modalWindowId == 1001 then
		if buttonId == 100 then
			if choiceId == 1 then
				player:registerEvent("ModalWindow_Teleport_Cities")
		
				local title = "Vip Teleport Stone"
				local message = "Escolha uma cidade:"
			
				local window = ModalWindow(1000, title, message)

				window:addChoice(1, "Ab'Dendriel")
				window:addChoice(2, "Ankrahmun")
				window:addChoice(3, "Carlin")
				window:addChoice(4, "Darashia")
				window:addChoice(5, "Edron")
				window:addChoice(6, "Farmine")
				window:addChoice(7, "Feyrist")
				window:addChoice(8, "Gray Island")
				window:addChoice(9, "Issavi")
				window:addChoice(10, "Kazordoon")
				window:addChoice(11, "Krailos")
				window:addChoice(12, "Liberty Bay")
				window:addChoice(13, "Port Hope")
				window:addChoice(14, "Rathleton")
				window:addChoice(15, "Roshamuul")
				window:addChoice(16, "Svargrond")
				window:addChoice(17, "Thais")
				window:addChoice(18, "Venore")
				window:addChoice(19, "Yalahar")
			
				window:addButton(101, "Cancel")
				window:addButton(100, "Confirm")
			
				window:setDefaultEnterButton(100)
				window:setDefaultEscapeButton(101)
			
				window:sendToPlayer(player)
			end
			if choiceId == 2 then
				if getHouseByPlayerGUID(getPlayerGUID(player)) then
					player:getPosition():sendMagicEffect(CONST_ME_SMOKE)
					player:teleportTo(getHouseEntry(getHouseByPlayerGUID(getPlayerGUID(player))))
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Teleported to your house.')
					return true
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You dont have a house.')
					return true
				end
			end	
			if choiceId == 3 then
				local guild = player:getGuild()
				if guild then
					local guildLeaderPlayerId = db.storeQuery("SELECT `ownerid` FROM `guilds` WHERE `id` = " .. guild:getId())
					local leaderId = result.getDataInt(guildLeaderPlayerId, "ownerid")
					result.free(guildLeaderPlayerId)
					local guildhouse = getHouseByPlayerGUID(leaderId)
					if guildhouse then
						player:getPosition():sendMagicEffect(CONST_ME_SMOKE)
						player:teleportTo(getHouseEntry(guildhouse))
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Teleported to guild house of your guild.')
						return true
					else
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Your guild dont have a guild house.')
						return true
					end
				end
			end	
		end	
	end
	return true
end

modalTpCities:register()