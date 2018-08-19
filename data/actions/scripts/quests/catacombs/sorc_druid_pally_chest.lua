local storage = 15001

local vocations = {
    {8920}, -- 1
    {7414}, -- 2
    {7368}, -- 3
    {7380}  -- 4
}

local msg = ''
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local book = player:addItem(6103, 1)
    if player:getStorageValue(storage) < 1 then
        for vocId, items in ipairs(vocations) do
            if player:getVocation():getBase():getId() == vocId then
                for i = 1, #items do
					local weapon = player:addItem(items[i])
					weapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for completing the Catacombs on " .. os.date("%B %d, %Y") .. ".")
                end
                msg = 'You earned a new weapon.'
            end
        end
        player:addItem(24774, 1)
        book:setAttribute(ITEM_ATTRIBUTE_TEXT, "Congrats ".. player:getName() ..", on completion of the Catacombs Quest on " .. os.date("%B %d, %Y") .. "! Thank you for playing with us on Decapitated Soul!")
        player:setStorageValue(storage, 1)
    else
        msg = "chest is empty."
    end
    player:sendTextMessage(MESSAGE_INFO_DESCR, msg)
    return true
end
