local the_unwelcome_damage = CreatureEvent("the_unwelcome_damage")

function the_unwelcome_damage.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    local damage = math.random(5,15)
    
    return creature, attacker, -damage, primaryType, -damage, secondaryType, origin
end

the_unwelcome_damage:register()
