local combat = Combat()
local time_between_hits = 0.2 --seconds
 
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_LOSEENERGY)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setArea(createCombatArea(AREA_SQUAREWAVE6))
 
function onGetFormulaValues(player, level, maglevel)
    local min = (level / 5) + (maglevel * 5) + 30
    local max = (level / 5) + (maglevel * 10) + 30
    return -min, -max
end
combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
function onCastSpell(creature, var)
    combat:execute(creature, var)
    addEvent(function() combat:execute(creature, var) end, time_between_hits * 1000)
    addEvent(function() combat:execute(creature, var) end, 300)
	addEvent(function() combat:execute(creature, var) end, 600)
	addEvent(function() combat:execute(creature, var) end, 900)
	addEvent(function() combat:execute(creature, var) end, 1200)
  return true
end
