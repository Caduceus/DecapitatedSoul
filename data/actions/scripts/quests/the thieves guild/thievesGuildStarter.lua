function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.thievesGuild.Quest) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this body is picked clean.")
    elseif player:getStorageValue(Storage.thievesGuild.Quest) < 1 then
    local item = player:addItem(1952, 1)
        item:setAttribute(ITEM_ATTRIBUTE_TEXT, "Dearest Dorian, \n  By the time you read this I will be long perished. The beasts in this new land are far stronger than we had anticipated. Other adventurers may be of great assistance to our cause. Recruit as many of them as you can! \n\nWith All of My Love,\nAmica")
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a note for Dorian in Port Lonrich!")
        player:setStorageValue(Storage.thievesGuild.Quest, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Get lost.")
       end
end
