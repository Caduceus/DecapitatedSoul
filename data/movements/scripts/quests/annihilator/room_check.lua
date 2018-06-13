local config = {
	centerRoomPosition = Position(777, 697, 8)
}

function onStepIn(creature, item, position, fromPosition)
local player = creature:getPlayer()
	if not player then
		return true
	end
  local specs, spec = Game.getSpectators(config.centerRoomPosition, false, false, 15, 15, 15, 15)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isMonster() then
				player:teleportTo(fromPosition, false)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have to kill all monsters first!")
                return true
            end  
	   end
   end 
