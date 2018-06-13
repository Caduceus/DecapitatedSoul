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
	if(not checkExhausted(player, 554, 60)) then
		return false
	end
	player:save()
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your character file for ".. player:getName() ..", has been saved. Keep in mind that your character will also save on advancement in skill, level, or logout.")
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
end
	