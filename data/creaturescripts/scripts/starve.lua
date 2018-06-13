function onThink(creature)
local condition = creature:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)

local function starve()
		creature:addHealth(-1)
		creature:say("You are starving.", TALKTYPE_MONSTER_SAY)
		return
	end	
		if condition and math.floor(condition:getTicks() / 1000) >= 0 then
		return false
	else
		addEvent(starve, 10 * 1000)	
	end
	return true
end