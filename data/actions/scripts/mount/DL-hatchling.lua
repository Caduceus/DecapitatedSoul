function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(10034) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this mount.")
        return false
    end
    if player:getStorageValue(10034) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have received the Dragon Lord Hatchling Mount!")
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:addMount(76)
        player:setStorageValue(10034, 1)
    end
end
