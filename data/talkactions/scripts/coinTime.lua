function checkExhausted(cid, storage, seconds)
	local player = Player(cid)
		if not player then
			return
	end
    local v = exhaustion.get(cid, storage)
    if(not v) then
        exhaustion.set(cid, storage, seconds)
    else
        player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Please wait " .. v .. " seconds before using this command again.")
        return false
    end
 
    return true
end


function onSay(player, words, param)
if(not checkExhausted(player, 554, 10)) then
    return false
end
	
	if player:getAccountStorageValue(accountStorage.addCoinTimer) == false then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Something went wrong or Admin.")
	elseif player:getAccountStorageValue(accountStorage.addCoinTimer) < os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Something went wrong. Your coin timer was reset. maybe.. please check again.")
		player:setAccountStorageValue(accountStorage.addCoinTimer, os.time() + 1*60*60)
		player:setAccountStorageValue(accountStorage.accountLastLogout, 0)
		player:addItem(24774, 1)
		print(">> Coin issue: " .. player:getAccountId() .. " [" .. player:getName() .. "] coin timer was reset. " .. os.date("%H:%M:%S") .. "")
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You were awarded a Tibia Coin, for the inconvenience. Happy Hunting.")
		player:save()
	elseif player:getAccountStorageValue(accountStorage.addCoinTimer) > os.time() then
         local time = player:getAccountStorageValue(accountStorage.addCoinTimer) - os.time()
         local hours, minutes, seconds = math.floor (time / 3600), math.floor ((time - ((math.floor (time / 3600)) * 3600))/ 60), time - ((math.floor (time/60)) * 60)
         if time >= 3600 then
             text = hours.." "..(hours == 1 and "hour" or "hours")..", "..minutes.." "..(minutes == 1 and "minute" or "minutes").." and "..seconds.." "..(seconds == 1 and "second" or "seconds")
         elseif time >= 60 then
             text = minutes.." "..(minutes == 1 and "minute" or "minutes").." and "..seconds.." "..(seconds == 1 and "second" or "seconds")
         else
             text = seconds.." "..(seconds == 1 and "second" or "seconds")
         end
         
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Time to get a coin: "..text..".")
         return false
     end
 end
 