function onThink(creature)
	if creature:getStorageValue(1015) == 1 then
		if creature:getStorageValue(1016) == 1 then
			if creature:getStorageValue(1017) == 1 then
				if creature:getStorageValue(1018) == 1 then
					creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'All the Maps are Burnt. Collect Captain Hook\'s hook, Then Return to Javy Dones!')
					creature:setStorageValue(1015, 2)
					creature:setStorageValue(1016, 2)
					creature:setStorageValue(1017, 2)
					creature:setStorageValue(1018, 2)
					creature:setStorageValue(2239, 4) -- storage of Pirate Boss Chain Advance
					creature:removeItem(9956, 1)
				end
			end
        end
    end
 end
 