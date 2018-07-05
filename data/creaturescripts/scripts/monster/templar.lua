function onThink(creature)
local master = creature:getMaster()
local conditions = {CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY, CONDITION_PARALYZE, CONDITION_DRUNK, CONDITION_DROWN, CONDITION_CURSED}
local party = master:getParty()
local heal = master:getMaxHealth() / 10
	if math.random(1, 100) <= 30 then
		if master then
		    master:addHealth(heal)
			master:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			for i, condition in ipairs(conditions) do
				master:removeCondition(condition)
			end
        end
        return true
    end
end
