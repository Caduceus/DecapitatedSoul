local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 200)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 4.8) + 16
	local max = (level / 5) + (maglevel * 8.4) + 28
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
