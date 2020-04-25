function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
    
	if item:getId() == 385 and player:getLevel() < 500 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It seems too narrow to climb through.")
		player:teleportTo(fromPosition, false)
		return true
	end
end