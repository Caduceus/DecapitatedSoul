local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition()
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_MANASHIELD)
combat:setCondition(condition)

function onCastSpell(creature, var)
    creature:setStorageValue(75004, -1)
    creature:unregisterEvent('ManaMessage')
    creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your mana shield has been turned off!")
    return combat:execute(creature, var)
end
