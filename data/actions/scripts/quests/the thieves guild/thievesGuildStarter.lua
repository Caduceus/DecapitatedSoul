function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(1952) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this body is picked clean.")
    elseif player:getStorageValue(1952) <= 1 then
    local item = player:addItem(1952, 1)
        item:setAttribute(ITEM_ATTRIBUTE_TEXT, "So, you fancy yourself a thief do you? You should see Dorian.")
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a note for Dorian in Drogheda!")
        --player:setStorageValue(thieveGuildId, 1)
        player:setStorageValue(1952, 1) --find storage id not used
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Get lost.")
       end
end
