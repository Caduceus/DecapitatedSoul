local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 300)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 2.4) + 8
	local max = (level / 5) + (maglevel * 4.2) + 14
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
