function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "The current date is " .. os.date("%D") .. ". \nThe time is " .. os.date("%H:%M:%S") .. ".") 
	return true
end
