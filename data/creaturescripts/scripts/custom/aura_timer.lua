function onThink(creature)
	if creature:getStorageValue(25951) == os.time() then
			creature:setStorageValue(25950, -1)
			creature:setStorageValue(25951, -1)
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your aura has worn off!")
        end
    end