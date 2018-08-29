function onThink(creature)
    local time = 1*60*60 -- 1s*60s = 60s * 60s = 60min
    local adminTime = 8*60*60 -- 1s*60s = 60s * 60s = 60min
    local count = 1 -- points to add
    file = "data/logs/playerCoinReward.txt"
    
    local function doWriteLogFile(file, text)
    local f = io.open(file, "a+")
    if not f then
        return false
    end

    f:write("" .. text .. " [" .. os.date("%m/%d/%Y %H:%M:%S") .. "]\n")
    f:close()
    return true
end
 
	local playerName = result.getString(resultId, "playerName")
	local logs = string.format("" ..creature:getName().. " gained 1 coin", logs, playerName)
	
    if creature:getStorageValue(455577) == os.time() then
		db.query("UPDATE `accounts` SET `coins` = `coins` + " .. count .. " WHERE `id` = " .. creature:getAccountId() .. ";")
		creature:sendTextMessage(MESSAGE_EVENT_ORANGE, "You gained " .. count .. " coin for being online for 1 hour. Your new coin balance is ".. creature:getCoinsBalance() ..".")
		creature:setStorageValue(455577, os.time() + time)
		creature:save()
		doWriteLogFile(file, logs)
		print(">> Coin awarded: " .. creature:getName() .. " recieved " .. count .. " coin on " .. os.date("%m/%d/%Y at %H:%M:%S") .. ".")
    end
end
