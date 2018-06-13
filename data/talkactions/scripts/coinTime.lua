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
 
	if player:getStorageValue(455577) > os.time() then
         local time = player:getStorageValue(455577) - os.time()
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