local config = {
    reward = {
        [1] = {2662, 2653, 5918},
        [2] = {2662, 2653, 5918},
        [3] = {2458, 2464, 2648},
        [4] = {2457, 2463, 2647},
        [9] = {2457, 2463, 2647}
    }
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(Storage.lowLevelGear) == -1 then
        local vocation = player:getVocation():getBase():getId()
        for i = 1, #config.reward[vocation] do
            player:addItem(config.reward[vocation][i], 1)
        end

        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found some useful items. Make your way to Soraya to continue your journey. You can find her to the North of here, in the shops area.")
        player:setStorageValue(Storage.lowLevelGear, 1)
        player:setTown(Town(1))
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
    end
    return true
end
