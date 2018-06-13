function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(15000) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "chest is empty.")
    elseif player:getStorageValue(15000) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a new mount!")
        player:addMount(51)
        player:setStorageValue(15000, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end