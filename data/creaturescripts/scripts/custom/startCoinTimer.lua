function onLogin(player)
local lastLogout = player:getAccountStorageValue(accountStorage.accountLastLogout)
local offlineTime = lastLogout ~= false and math.min(os.time() - lastLogout, 86400 * 21) or false
local time = 1*60*60 -- 1s*60s = 60s * 60s = 60min
	if player:getAccountId() == 1 or player:getAccountId() == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "[Admin Account]: Your current coin balance is ".. player:getCoinsBalance() ..".")
	elseif player:getAccountStorageValue(accountStorage.addCoinTimer) == false or player:getAccountStorageValue(accountStorage.addCoinTimer) < os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "For every 1 hour online, you will receive 1 coin to use in the store. Your current coin balance is ".. player:getCoinsBalance() ..".")
		player:setAccountStorageValue(accountStorage.addCoinTimer, os.time() + time)
		player:save()
	elseif offlineTime < 300 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Your coin timer did not reset! Use command !coin to see your time remaining.")
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Your current coin balance is ".. player:getCoinsBalance() ..".")
	else
		player:setAccountStorageValue(accountStorage.addCoinTimer, os.time() + time)
		player:save()
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "For every 1 hour online, you will receive 1 coin to use in the store. Your current coin balance is ".. player:getCoinsBalance() ..".")
	end
	return true
end
