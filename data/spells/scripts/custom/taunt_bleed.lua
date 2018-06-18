function onTargetCreature(creature, target)
	return doChallengeCreature(creature, target)
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 250)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local condition = Condition(CONDITION_BLEEDING)
condition:setParameter(CONDITION_PARAM_DELAYED, 10)
condition:addDamage(15, 2000, -50)
combat:setCondition(condition)

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.06) + 13
    local max = (player:getLevel() / 5) + (skill * attack * 0.14) + 34
    return -min, -max
end 

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
