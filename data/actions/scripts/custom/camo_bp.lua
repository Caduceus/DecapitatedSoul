function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(3940) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this corpse is empty.")
    elseif player:getStorageValue(3940) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a camouflage backpack!")
        player:addItem(3940, 1):addItem(3965, 1)
        player:setStorageValue(3940, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end