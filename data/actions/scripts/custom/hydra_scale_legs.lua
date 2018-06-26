function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(9928) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this body is empty.")
    elseif player:getStorageValue(9928) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a pair of hydra scale legs!")
        player:addItem(9928, 1)
        player:setStorageValue(9928, 1)
       end
end
