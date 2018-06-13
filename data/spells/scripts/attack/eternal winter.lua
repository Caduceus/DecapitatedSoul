local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 250)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 8.0) + 25
	local max = (level / 5) + (maglevel * 16) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
