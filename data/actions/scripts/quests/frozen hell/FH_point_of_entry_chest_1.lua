local cfgItems = {{22604, 1}, {24774, 2}, {22649, 1}}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(15007) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "this chest is empty.")
    elseif player:getStorageValue(15007) <= 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a reward chest!")
        
        local bag = player:addItem(5927) -- Bag id
        for i = 1, #cfgItems do
            bag:addItem(cfgItems[i][1], cfgItems[i][2])
        end
        player:setStorageValue(15007, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You Fucked Up!.")
       end
end
