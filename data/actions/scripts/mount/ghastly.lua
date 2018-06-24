function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(15002) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this mount.")
        return false
    end
    if player:getStorageValue(15002) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You now have the Ghastly Dragon Mount!")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:addMount(75)
        item:remove(1)
        player:setStorageValue(15002, 1)
    end
end
