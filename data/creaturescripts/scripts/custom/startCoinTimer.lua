function onLogin(player)
local lastLogout = player:getLastLogout()
local offlineTime = lastLogout ~= 0 and math.min(os.time() - lastLogout, 86400 * 21) or 0
local time = 1*60*60 -- 1s*60s = 60s * 60s = 60min
	if player:getAccountId() == 1 or player:getAccountId() == 2 then
		--player:setStorageValue(455577, -1)
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "[Admin Account]: Your current coin balance is ".. player:getCoinsBalance() ..".")
	elseif player:getLastLoginSaved() <= 0 then
		player:setStorageValue(455577, os.time() + time)
		player:save()
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "For every 1 hour online, you will receive 1 coin to use in the store. Your current coin balance is ".. player:getCoinsBalance() ..".")
	elseif offlineTime < 300 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your coin timer did not reset! Use command !coin to see your time remaining.")
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Your current coin balance is ".. player:getCoinsBalance() ..".")
	else
		player:setStorageValue(455577, os.time() + time)
		player:save()
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "For every 1 hour online, you will receive 1 coin to use in the store. Your current coin balance is ".. player:getCoinsBalance() ..".")
	end
	return true
end
