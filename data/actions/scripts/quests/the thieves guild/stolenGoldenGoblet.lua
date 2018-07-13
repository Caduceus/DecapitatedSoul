function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.thievesGuild.Goblet) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this box is empty.")
    elseif player:getStorageValue(Storage.thievesGuild.Goblet) == -1 then
		player:addItem(8698, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found the stolen golden goblet.")
        player:setStorageValue(Storage.thievesGuild.Goblet, 1)
       end
end
