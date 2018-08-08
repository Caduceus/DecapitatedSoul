function onThink(creature)
    if creature:getStorageValue(75004) == 1 then
        if not creature:getCondition(CONDITION_MANASHIELD) then
            creature:setStorageValue(75004, 0)
            creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your mana shield has worn off!")
        end
    end
end
