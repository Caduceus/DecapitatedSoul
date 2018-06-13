local storage = 45554

local outfits = {
    [1] = {female = 138, male = 130, addon = 3}, -- 1
    [2] = {female = 148, male = 144, addon = 3}, -- 2
    [3] = {female = 137, male = 129, addon = 3}, -- 3
    [4] = {female = 139, male = 131, addon = 3}, -- 4
    [9] = {female = 142, male = 134, addon = 3}  -- 9 custom voc
}

local msg = ''
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(storage) == 2 then
        local outfit = outfits[player:getVocation():getBase():getId()]
        player:addOutfitAddon(outfit.female, outfit.addon)
        player:addOutfitAddon(outfit.male, outfit.addon)
        msg = "You received a free addon!"
        player:setStorageValue(storage, 3)
    else
        msg = " The chest seems to be locked."
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, msg)
    return true
end