local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISONARROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 2, 0, 2, 0)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, true)
condition:addDamage(5, 4000, -3)
condition:addDamage(15, 4000, -2)
condition:addDamage(30, 4000, -1)
combat:setCondition(condition)

function onUseWeapon(player, variant)
	return combat:execute(player, variant)
end
