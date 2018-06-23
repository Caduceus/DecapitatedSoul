function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getAccountStorageValue(accountStorage.doubleXpGrant) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "A character on your account has already found this chest.")
    elseif player:getAccountStorageValue(accountStorage.doubleXpGrant) == false then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You found a double experience grant!")
        player:addItem(1948, 1)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:setAccountStorageValue(accountStorage.doubleXpGrant, 1)
       end
end
