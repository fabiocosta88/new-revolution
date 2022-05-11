local refiller = TalkAction("!refiller")

function refiller.onSay(player, words, param)	
    if player:removeMoneyBank(50000) then
        local position = player:getPosition()
        local npc = Game.createNpc("Refiller", position)
        local keywordHandler = KeywordHandler:new()
        local npcHandler = NpcHandler:new(keywordHandler)
        npcHandler:greet(npc, player, "hi")
        player:getPosition():sendMagicEffect(CONST_ME_ICEATTACK)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendCancelMessage("Refiller spawned.")
        return true
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage("You do not have enough money.")
    end
end

refiller:register()
