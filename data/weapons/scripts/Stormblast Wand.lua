local combat = Combat()
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setFormula(COMBAT_FORMULA_SKILL, 1, 0, 1, 0)

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(10, 2000, -10)
combat:setCondition(condition)

function onUseWeapon(player, var)
	return combat:execute(player, var)
	end