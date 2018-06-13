--[[function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end]]

function onSay(player, words, param)
    local target = Player(param)
    if not player:getGroup():getAccess() then
        return true
    end

    if target == nil then
        --player:sendCancelMessage("Player not found.")
        player:teleportTo(player:getTown():getTemplePosition())
        return false
    end
	
    target:teleportTo(target:getTown():getTemplePosition())
    player:sendCancelMessage('You have sent ' .. target:getName() .. ' to their temple.')
    return false
end
