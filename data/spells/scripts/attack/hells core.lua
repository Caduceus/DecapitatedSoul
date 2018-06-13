local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 200)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 250)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 8) + 50
	local max = (level / 5) + (maglevel * 12) + 75
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
