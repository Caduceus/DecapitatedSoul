local cfgItems = {{1948, 1}, {1948, 1}, {1948, 1}, {1948, 1}, {1948, 1}}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(15008) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this chest is empty.")
    elseif player:getStorageValue(15008) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found 5 hours worth of double experience!")
        
        local bag = player:addItem(5927) -- Bag id
        for i = 1, #cfgItems do
            bag:addItem(cfgItems[i][1], cfgItems[i][2])
        end
        player:setStorageValue(15008, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You Fucked Up!.")
       end
end
