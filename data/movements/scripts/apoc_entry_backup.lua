function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	
		if player:getItemCount(6500) > 0 then
			player:teleportTo(Position(424, 524, 8))
			player:removeItem(2684, 1)
	
	
	local destination = Tile(Position(1049, 702, 3))
	local item = player:getItemById(6500)
	if not item then
	print(item)
		destination = Position(1042, 701, 2)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You do not have required amount of demonic essences to enter!")
		player:teleportTo(destination)
		destination:sendMagicEffect(CONST_ME_TELEPORT)
		return false
	end
	
	sacrificeItem:remove(1)
	destination = Position(424, 524, 8)
	player:teleportTo(destination)
	destination:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end
