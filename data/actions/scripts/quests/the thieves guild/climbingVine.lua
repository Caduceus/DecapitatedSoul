local config = {
	[12501] = Position(981, 1061, 6), -- to the room
	[12502] = Position(981, 1063, 7) -- outside the room
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

	player:teleportTo(targetPosition)

	return true
end
