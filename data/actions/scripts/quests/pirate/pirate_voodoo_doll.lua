local storage = 2239

local msg = ''
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(storage) == -1 then
        player:addOutfitAddon(749, 3)
        player:addOutfitAddon(750, 3)
        msg = "You received the pirate addon!"
        player:setStorageValue(storage, -1)
        item:remove(1)
    else
        msg = " Good try."
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, msg)
    return true
end
