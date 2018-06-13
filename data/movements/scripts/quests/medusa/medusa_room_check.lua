local config = {
	centerRoomPosition = Position(82, 71, 6)
}

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
	if not player then
		return true
	end
	--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
  local specs, spec = Game.getSpectators(config.centerRoomPosition, true, false, 37, 37, 23, 29)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isMonster() then
				player:teleportTo(fromPosition, false)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You must to kill all monsters in the dungeon before you may enter!")
                return true
            end  
	   end
   end 
