function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local target = Player(param)
	if target == nil then
		player:sendCancelMessage("Player not found.")
		return false
	end

	if target:getAccountType() >= ACCOUNT_TYPE_GOD then
		player:sendCancelMessage("You cannot kick this player.")
		return false
	end
	
	target:remove()
	return false
end
