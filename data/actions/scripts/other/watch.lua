function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "The current day is " .. os.date("%A %B %d, %Y") .. ". \nThe time is " .. os.date("%X") .. ".") 
	return true
end
