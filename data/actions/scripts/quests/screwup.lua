local outfits = {
    {female = 138, male = 130, addon = 3}, -- 1
    {female = 148, male = 144, addon = 3}, -- 2
    {female = 137, male = 129, addon = 3}, -- 3
    {female = 139, male = 131, addon = 3}, -- 4
    {female = 139, male = 131, addon = 3}, -- not active
    {female = 139, male = 131, addon = 3}, -- not active
    {female = 139, male = 131, addon = 3}, -- not active
    {female = 139, male = 131, addon = 3}, -- not active
    {female = 142, male = 134, addon = 3}  -- 9
}

local msg = ''
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(45552) == -1 then
        local outfit = outfits[player:getVocation():getBase():getId()]
        player:addOutfitAddon(outfit.female, outfit.addon)
        player:addOutfitAddon(outfit.male, outfit.addon)
        msg = "Sorry about that. ~ Caduceus"
        player:setStorageValue(Storage.vocationAddon, 3)
        player:setStorageValue(Storage.gateKeeperMission.mission, 3)
        player:setStorageValue(Storage.keatonMisson.mission, 2)
        player:setStorageValue(Storage.carrionMission.mission, 5)
        player:setStorageValue(45552, 1)
        player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
    else
        msg = "Shit out of luck, ".. player:getName() .."."
    end
    
    player:sendTextMessage(MESSAGE_INFO_DESCR, msg)
    return true
end
