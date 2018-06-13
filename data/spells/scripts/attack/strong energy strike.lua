local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 300)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4.8) + 16
	local max = (level / 5) + (maglevel * 8.4) + 28
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
