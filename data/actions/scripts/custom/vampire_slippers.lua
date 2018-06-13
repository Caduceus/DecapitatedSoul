function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(21708) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this body is empty.")
    elseif player:getStorageValue(21708) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a pair of Vampire Silk Slippers!")
        player:addItem(21708, 1)
        player:setStorageValue(21708, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end
