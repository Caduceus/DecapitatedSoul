function onThink(creature)
	if creature:getStorageValue(1233) == os.time() then
			creature:setStorageValue(1233, -1)
			creature:sendTextMessage(MESSAGE_INFO_DESCR, "Your 30 minutes of double XP has ended!")
        end
    end
    
function onThink(creature)
	if creature:getStorageValue(1234) == os.time() then
			creature:setStorageValue(1234, -1)
			creature:sendTextMessage(MESSAGE_INFO_DESCR, "Your 1 hour of double XP has ended!") 
        end
    end
    