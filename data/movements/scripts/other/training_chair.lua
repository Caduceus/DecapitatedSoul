function onStepIn(player, item, position, fromPosition)

if player:getAccountId() == 2 then
	player:teleportTo(player:getTown():getTemplePosition())
	player:remove()
	return true
	end
end