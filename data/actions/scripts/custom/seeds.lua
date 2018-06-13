function onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if target:getId() == 7655 then 
			target:transform(7673)
			Item(item.uid):remove(1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "it works?!")
		end
	return true
end