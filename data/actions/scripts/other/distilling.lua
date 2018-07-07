function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if item.itemid == 5467 and target.itemid == 5469 then
		target:transform(5513)
		item:remove(1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have made rum!")
	return true
	elseif item.itemid == 5467 and target.itemid == 5470 then
		target:transform(5514)
		item:remove(1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have made rum!")
	return true
	end
end