local storage = 15009

local vocations = {
    {18390}, -- 1
    {8910}, -- 2
    {15644,18435}, -- 3
    {12649}  -- 4
}

local msg = ''
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(storage) < 1 then
        for vocId, items in ipairs(vocations) do
            if player:getVocation():getBase():getId() == vocId then
				for i = 1, #items do
					local weapon = player:addItem(items[i])
						weapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for the completion of Frozen Hell on " .. os.date("%B %d, %Y") .. ".")
                end
                msg = 'Congratulations on the completion of Frozen Hell!'
            end
        end
        player:setStorageValue(storage, 1)
    else
        msg = "chest is empty."
    end
    player:sendTextMessage(MESSAGE_INFO_DESCR, msg)
    return true
end
