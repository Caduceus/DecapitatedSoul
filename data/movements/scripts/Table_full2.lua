local playerPositions = Position(1040, 936, 10)

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end
        local specs, spec = Game.getSpectators(playerPositions, false, false, 1, 1, 1, 1)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
				player:teleportTo(fromPosition, false)
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "You Shall Not Pass.")
                return true
            end
		end
	end