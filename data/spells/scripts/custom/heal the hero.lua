local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BUBBLES)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_SUBID, 1)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
condition:setParameter(CONDITION_PARAM_TICKS, 2 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 100)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 2000)


function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 6.3) + 90
	local max = (level / 5) + (maglevel * 14.4) + 180
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
