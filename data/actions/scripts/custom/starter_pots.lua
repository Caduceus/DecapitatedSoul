function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(7590) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this body is empty.")
    elseif player:getStorageValue(7590) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found 100 healing pots and 100 mana pots!")
        player:addItem(7591, 100)
        player:addItem(7590, 100)
        player:setStorageValue(7590, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end