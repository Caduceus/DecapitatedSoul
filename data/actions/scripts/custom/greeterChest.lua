local chestOpened = 45554
local gateKeeper = Position(1047, 906, 6)
local time_ = 4 -- in seconds
local outfits = {
    [1] = {female = 138, male = 130, addon = 3}, -- 1
    [2] = {female = 148, male = 144, addon = 3}, -- 2
    [3] = {female = 137, male = 129, addon = 3}, -- 3
    [4] = {female = 139, male = 131, addon = 3}, -- 4
    [9] = {female = 142, male = 134, addon = 3}  -- 9 custom voc
}

local msg = ''
function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local function instruction()
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Make your way through the gate tower.")
	end
	
	local function greeterPort()
		if player:getStorageValue(chestOpened) == 3 then
			player:teleportTo(gateKeeper)
			addEvent(instruction, time_ * 1000)
		end
	end
	
    if player:getStorageValue(chestOpened) == 2 then
        local outfit = outfits[player:getVocation():getBase():getId()]
        player:addOutfitAddon(outfit.female, outfit.addon)
        player:addOutfitAddon(outfit.male, outfit.addon)
        msg = "You received a free addon! Now on to your next Adventure!"
        player:setStorageValue(chestOpened, 3)
        player:save()
        addEvent(greeterPort, time_ * 1000)
    else
        msg = " The chest seems to be locked."
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, msg)
    return true
end
