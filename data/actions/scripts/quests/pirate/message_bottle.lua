function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(2239) == 1 then
        player:sendCancelMessage('this bottle is empty.')
        return false
    end
    if player:getStorageValue(2239) <= 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You found a message, tucked inside the bottle!")
        player:addItem(2239, 1):setAttribute(ITEM_ATTRIBUTE_TEXT, "Halp Men Plix \n\nOn mountain south of island. \n~Javy Dones")
        player:setStorageValue(2239, 1) --Set as quest Storage
    end
end
