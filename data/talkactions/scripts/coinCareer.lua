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

         
         player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Career Coin Total: " .. player:getCoinsCareer() .. "")
         return false
     end
 