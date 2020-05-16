function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
	
	local target = Creature(param)
	local message = "".. target:getName() ..", WARNING MESSAGE HERE!"
	if target == nil then
		player:sendCancelMessage("Creature not found.")
		return false
	end	
	--target:popupFYI(message)
	target:sendPrivateMessage(player, message, TALKTYPE_PRIVATE_RED_FROM)
	print(player:getName())
	return false
end
