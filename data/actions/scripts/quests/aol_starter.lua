function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(2173) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this body is empty.")
    elseif player:getStorageValue(2173) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found an amulet of loss!")
        player:addItem(2173, 1)
        player:setStorageValue(2173, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end