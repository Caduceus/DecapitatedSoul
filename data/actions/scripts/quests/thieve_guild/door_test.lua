function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(2092) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this body is picked clean.")
    elseif player:getStorageValue(2092) <= 1 then
    local item = player:addItem(2092, 1)
        --item:setAttribute(ITEM_ATTRIBUTE_TEXT, "So, you fancy yourself a thief do you? You should see Draven.")
        item:setActionId(2092)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a note for Draven in Drogheda!")
        --player:setStorageValue(thieveGuildId, 1)
        player:setStorageValue(2092, 1) --find storage id not used
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Get lost.")
       end
end

