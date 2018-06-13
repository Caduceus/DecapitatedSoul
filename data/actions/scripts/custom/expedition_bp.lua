function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(11241) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this corpse is empty.")
    elseif player:getStorageValue(11241) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a expedition backpack!")
        player:addItem(11241, 1):addItem(11219, 1)
        player:setStorageValue(11241, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end
