local storage = 15483

local vocations = {
    {2190, 8900}, -- 1
    {2182, 8900}, -- 2
    {2456, 2544}, -- 3
    {2388, 2406, 2448, 2526}, -- 4
    {}, -- 5
    {}, -- 6
    {}, -- 7
    {}, -- 8
    {2388, 2406, 2448, 2526}  -- 9
}

local msg = ''
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(storage) < 1 then
        for vocId, items in ipairs(vocations) do
            if player:getVocation():getBase():getId() == vocId then
                for i = 1, #items do
                    player:addItem(items[i])
                end
                msg = "You have found some useful gear!"
            end
        end
        player:setStorageValue(storage, 1)
    else
        msg = "chest is empty."
    end
    player:sendTextMessage(MESSAGE_INFO_DESCR, msg)
    return true
end
