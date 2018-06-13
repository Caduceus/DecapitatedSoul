function onThink(creature)
local config = { 
	hp = creature:getHealth(),
	maxhp = creature:getMaxHealth(),
    heal = math.random(300, 1000),
    }
               
    if (config.hp * 100)/config.maxhp < 50 then
		doCreatureAddHealth(creature, config.heal)
		creature:say('I will never Die!', TALKTYPE_MONSTER_SAY)
	return true
	end
        if (config.hp * 100)/config.maxhp <= 30 then
		Game.createMonster("medusa snake", creature:getPosition())
		return true
	end
end