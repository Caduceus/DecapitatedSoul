local storage = Storage.thievesGuild.BarbarianQueenChest
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(storage) == 2 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have this item.")
        return false
    end
    if player:getStorageValue(storage) > os.time() then
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:addItem(4841, 1)
        player:setStorageValue(storage, 2)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have received the Deed to Port Lonrich!")
    end
end
