local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BUBBLES)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_SUBID, 2)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 2)
condition:setParameter(CONDITION_PARAM_TICKS, 1 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 250)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 3000)
condition:setParameter(CONDITION_PARAM_EFFECT, CONST_ME_STUN)
condition:setParameter(CONDITION_PARAM_LIGHT_COLOR, 5)
combat:setCondition(condition)

--[[local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_SUBID, 3)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 3)
condition:setParameter(CONDITION_PARAM_TICKS, 1 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_MANAGAIN, 50)
condition:setParameter(CONDITION_PARAM_MANATICKS, 3000)
condition:setParameter(CONDITION_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat:setCondition(condition)

local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 4)
condition:setParameter(CONDITION_PARAM_TICKS, 40000)
condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 10)
combat:setCondition(condition)]]

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 6.3) + 90
	local max = (level / 5) + (maglevel * 14.4) + 180
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
