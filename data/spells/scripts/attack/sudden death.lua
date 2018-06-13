local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 300)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 6.0) + 32
	local max = (level / 5) + (maglevel * 10.0) + 48
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end
