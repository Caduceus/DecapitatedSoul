function onThink(creature)
    local time = 1*60*60 -- 1s*60s = 60s * 60s = 60min
    local adminTime = 8*60*60 -- 1s*60s = 60s * 60s = 60min
    local count = 1 -- points to add
 
    if creature:getStorageValue(455577) == os.time() and creature:getAccountId() == 1 then
				creature:setStorageValue(455577, -1)
			return true
		end
		
	if creature:getStorageValue(455577) == os.time() and creature:getAccountId() == 2 then
		creature:sendTextMessage(MESSAGE_EVENT_ORANGE, "Thank you for you dedication! You have been with me through thick & thin!")
		creature:setStorageValue(455577, os.time() + adminTime)
		return true
	end
			
    if creature:getStorageValue(455577) == os.time() then
		db.query("UPDATE `accounts` SET `coins` = `coins` + " .. count .. " WHERE `id` = " .. creature:getAccountId() .. ";")
		creature:sendTextMessage(MESSAGE_EVENT_ORANGE, "You gained " .. count .. " coin for being online for 1 hour.")
		creature:setStorageValue(455577, os.time() + time)
		creature:save()
    end
end

