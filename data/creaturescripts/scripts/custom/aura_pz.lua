function onThink(creature)

local pos = creature:getPosition()
    if creature:getStorageValue(25950) == 2 and getTilePzInfo(pos) == true then
            creature:setStorageValue(25950, -1)
			creature:setStorageValue(25951, -1)
            --creature:say('Your mana shield has worn off!', TALKTYPE_MONSTER_SAY)
            creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your aura has worn off due to protection zone")
    end
end
