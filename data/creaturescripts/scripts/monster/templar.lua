function onThink(creature)
local master = creature:getMaster()
local conditions = {CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY, CONDITION_PARALYZE, CONDITION_DRUNK, CONDITION_DROWN, CONDITION_CURSED}
local MIN,MAX = master:getMaxHealth() / 50, master:getMaxHealth() / 25
local heal = master:getMaxHealth() / 10
	if math.random(1, 100) <= 50 then
		if master then
		    master:addHealth(math.random(MIN, MAX))
			master:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			for i, condition in ipairs(conditions) do
				master:removeCondition(condition)
			end
        end
        return true
    end
end
