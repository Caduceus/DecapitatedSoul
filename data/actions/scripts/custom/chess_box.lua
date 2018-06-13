function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(20620) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this corpse is empty.")
    elseif player:getStorageValue(20620) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a Zaoan chess box!")
        player:addItem(20620, 1):addItem(2632, 1)
        player:setStorageValue(20620, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end