function onThink(creature)
    local time = 1*60*60 -- 1s*60s = 60s * 60s = 60min
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
	local logs = string.format("Account Id:" .. creature:getAccountId() .. " - Account Name:" .. creature:getAccountNameById() .. " - Character: [" ..creature:getName().. "] gained 1 coin", logs, playerName)
	local logsBonus = string.format("Account Id:" .. creature:getAccountId() .. " - Account name:" .. creature:getAccountNameById() .. " - Character: [" ..creature:getName().. "] gained 1 coin and 1 tibia coin", logsBonus, playerName)
	local random = math.random(20)
	
    if creature:getAccountStorageValue(accountStorage.addCoinTimer) == os.time() then 
		if random == 20 then
			db.query("UPDATE `accounts` SET `coins` = `coins` + " .. count .. " WHERE `id` = " .. creature:getAccountId() .. ";")
			creature:sendTextMessage(MESSAGE_EVENT_ORANGE, "You gained " .. count .. " coin and 1 tibia coin, for being online for 1 hour. Your new coin balance is ".. creature:getCoinsBalance() ..".")
			creature:setAccountStorageValue(accountStorage.addCoinTimer, os.time() + time)
			creature:addItem(24774, 1)
			creature:save()
			doWriteLogFile(file, logsBonus)
			sendChannelMessage(9, TALKTYPE_CHANNEL_R1, ">> Coin awarded: ~ " .. creature:getAccountId() .. " ~ [" .. creature:getName() .. "] recieved " .. count .. " coin and 1 tibia coin on " .. os.date("%m/%d/%Y at %H:%M:%S") .. ".")
			print(">> Coin and bonus awarded: " .. creature:getAccountId() .. " [" .. creature:getName() .. "] recieved " .. count .. " coin and 1 tibia coin on " .. os.date("%m/%d/%Y at %H:%M:%S") .. ".")
		elseif random <= 19 then
			db.query("UPDATE `accounts` SET `coins` = `coins` + " .. count .. " WHERE `id` = " .. creature:getAccountId() .. ";")
			creature:sendTextMessage(MESSAGE_EVENT_ORANGE, "You gained " .. count .. " coin for being online for 1 hour. Your new coin balance is ".. creature:getCoinsBalance() ..".")
			creature:setAccountStorageValue(accountStorage.addCoinTimer, os.time() + time)
			creature:save()
			doWriteLogFile(file, logs)
			sendChannelMessage(9, TALKTYPE_CHANNEL_R1, ">> Coin awarded: ~ " .. creature:getAccountId() .. " ~ [" .. creature:getName() .. "]  recieved " .. count .. " coin on " .. os.date("%m/%d/%Y at %H:%M:%S") .. ".")
			print(">> Coin awarded: " .. creature:getAccountId() .. " [" .. creature:getName() .. "] recieved " .. count .. " coin on " .. os.date("%m/%d/%Y at %H:%M:%S") .. ".")
		end
    end
end
