function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(15000) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this mount.")
    elseif player:getStorageValue(15000) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You now have the Chocobo mount!")
        doSendMagicEffect(pos, CONST_ME_FIREWORK_RED)
        player:addMount(2)
        doRemoveItem(item.uid, 1) -- remove the item
        player:setStorageValue(15000, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end