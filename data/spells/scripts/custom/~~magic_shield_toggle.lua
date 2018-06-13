local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
 
local condition = Condition(CONDITION_MANASHIELD, CONDITIONID_DEFAULT)
condition:setParameter(CONDITION_PARAM_TICKS, -1)
combat:setCondition(condition)
 
function onCastSpell(creature, var)
    local pos = creature:getPosition()
    if not creature:getCondition(CONDITION_MANASHIELD, CONDITIONID_DEFAULT) then
        pos:sendMagicEffect(13)
        creature:say("[ON]", TALKTYPE_MONSTER_SAY)
        return combat:execute(creature, var)
    end
    pos:sendMagicEffect(14)
    creature:say("[OFF]", TALKTYPE_MONSTER_SAY)
    return creature:removeCondition(CONDITION_MANASHIELD, CONDITIONID_DEFAULT)
end