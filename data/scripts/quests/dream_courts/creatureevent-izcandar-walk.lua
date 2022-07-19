local izcandar_walk = MoveEvent()

function izcandar_walk.onStepIn(creature, item, position, fromPosition)
    local monster = creature:getMonster()
    if not monster then
        return true
    end
    if monster:getName():lower() == 'izcandar champion of summer' or monster:getName():lower() == 'izcandar the banished' then
        if item.itemid == 799 then
            local life = monster:getHealth()
            local pos = monster:getPosition()
            monster:remove()
            local newmonster = Game.createMonster("Izcandar Champion of Winter", pos)
            newmonster:setHealth(life)
        end
    elseif monster:getName():lower() == 'izcandar champion of winter' or monster:getName():lower() == 'izcandar the banished' then
        if item.itemid == 106 then
            local life = monster:getHealth()
            local pos = monster:getPosition()
            monster:remove()
            local newmonster = Game.createMonster("Izcandar Champion of Summer", pos)
            newmonster:setHealth(life)
        end
    end
    return true
end

izcandar_walk:type("stepin")
izcandar_walk:id(799)
izcandar_walk:id(106)
izcandar_walk:register()