local config = {
    level = 250,
    storage = 15009,
	resetStorage = 21920,
    centerRoomPosition = Position(520, 1358, 10),
    stand = {x = 519, y = 1346, z = 6},
    playerDestination = {x = 520, y = 1375, z = 10}
}

--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local specs, spec = Game.getSpectators(config.centerRoomPosition, false, false, 20, 20, 20, 20)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "A player is already inside the quest room.")
                return true
            end
			
            spec:remove()
        end

	if player:getPosition() ~= Position(config.stand) then
	player:sendTextMessage(MESSAGE_STATUS_SMALL, "You must stand on the pressure plate.")
		return true
	end
    
    if player:getStorageValue(config.storage) == 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already completed this quest.")
        return true
    end
      
		player:setStorageValue(config.resetStorage, -1)
        player:teleportTo(config.playerDestination, false)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Good luck. You will need it!")
        item:transform(item.itemid == 1945 and 1946 or 1945)
    return true
end