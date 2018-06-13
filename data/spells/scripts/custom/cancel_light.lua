local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition()
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_LIGHT)
combat:setCondition(condition)

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
