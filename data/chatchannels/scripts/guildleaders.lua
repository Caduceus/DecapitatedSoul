function canJoin(player)
	return player:getGuildLevel() == 3 or player:getAccountType() >= ACCOUNT_TYPE_GOD
end

function onSpeak(player, type, message)
	local staff = player:getGroup():getAccess()
	local guild = player:getGuild()
	local info = "staff"
	type = TALKTYPE_CHANNEL_Y
	
	if staff then
		if guild then
			info =  info .. "][" .. guild:getName()
		else
			info =  info .. "
		end
		type = TALKTYPE_CHANNEL_O
	else
		info = guild:getName()
	end
	
	sendChannelMessage(10, type, player:getName() .. " [" .. info .. "]: " .. message)
	return false
end