local addon_config = {
    [1] = {
        name = "Assassin Outfit",
        achivement = "nome do achievmet, se tiver dois pfvr colocar achivment_1 = blabolabla, achivment_2 = blablabla, um emabixo do outro",
        outfit = {
            male = 152,
            female = 156
        },
        first = {
            items = {
                {5912,50},{5910,50},{5909,50},{5913,50},{5914,50},{5911,50},{5886,10}
            }
        },
        second = {
            items = {
                {5930,1},{5804,1}
            }
        }
    },
}

local function openAddonsChooseWindow(player) 
    if not player then
        return false
    end

    player:registerEvent("ModalWindow_AddonModal")
 
    local title = "Lista de Addons"
    local message = "Abaixo esta todos os addons que voce nao possui, escolha um e veja seus requisitos e caso possua todos resgate o addon."

    local window = ModalWindow(1008, title, message)
    
    window:addButton(101, "Cancelar")
	window:addButton(100, "Confirmar")

    for index, value in ipairs(addon_config) do
        window:addChoice(index, value.name)
    end

    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
 
    window:sendToPlayer(player)
    return true
end

local function openAddonNumberChoose(player) 
    if not player then
        return false
    end

    player:registerEvent("ModalWindow_AddonNumberchooseModal")
 
    local title = "Assassin Outfit"
    local message = "Escolha qual addon deseja fazer."

    local window = ModalWindow(1008, title, message)
    
    window:addButton(101, "Cancelar")
	window:addButton(100, "Confirmar")

    window:addChoice(1, "First addon")
    window:addChoice(2, "Second addon")

    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
 
    window:sendToPlayer(player)
    return true
end

local function openSpecificAddon(player)
    if not player or addon then
        return false
    end

    player:registerEvent("ModalWindow_AddonChooseModal")
 
    local title = "Requisitos do Addon"
    local message = "Assasin outfit Addon 1\n50x Cloth xxx\n50x Cloth yyy"

    local window = ModalWindow(1009, title, message)
    
    window:addButton(101, "Voltar")
	window:addButton(100, "Confirmar")

    window:setDefaultEnterButton(100)
    window:setDefaultEscapeButton(101)
 
    window:sendToPlayer(player)
end


local internalNpcName = "Addoner"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 9
}

npcConfig.flags = {
	floorchange = false
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if message then
        if MsgContains(message, "addons") then
            openAddonsChooseWindow(creature)
        end
        if MsgContains(message, "batata") then
            openAddonNumberChoose(creature)
        end
        if MsgContains(message, "teste") then
            openSpecificAddon(creature)
        end
    end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcHandler:addModule(FocusModule:new())

-- npcType registering the npcConfig table
npcType:register(npcConfig)
