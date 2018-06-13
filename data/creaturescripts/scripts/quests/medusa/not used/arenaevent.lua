function onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    local arena = CreatureArena[creature:getId()]
    if arena then
        arena:monsterDeath()
        CreatureArena[creature:getId()] = nil
    end
 
    return true
end