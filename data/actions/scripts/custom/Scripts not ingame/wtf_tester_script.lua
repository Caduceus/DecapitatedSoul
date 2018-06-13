function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item.itemid == 1945 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "WTF.")
    end
    return true
end