local cfgItems = {{8849, 1}, {7378, 1}, {2516, 1}, {2160, 1}}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getActionId(15000) and player:getStorageValue(15000) == 2 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already chosen your reward.")
    elseif player:getStorageValue(2600) <= 2 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a modified cross bow, a royal spear, a dragon shield and 1 crystal coin!")
         
        local bag = player:addItem(1991) -- Bag id
        for i = 1, #cfgItems do
            bag:addItem(cfgItems[i][1], cfgItems[i][2])
        end
        player:setStorageValue(2600, 1)
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
end