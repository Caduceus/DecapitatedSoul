local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter( COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter( COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter( COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat:setParameter( COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetFormulaValues(cid)
local min = 600
local max = 1200
return doPlayerAddMana(cid, math.random(min, max))
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

