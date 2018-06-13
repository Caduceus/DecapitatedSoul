function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    if player:getGroup():getAccess() then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Admin Access.")
		return true
	end
    if player:getStorageValue(15001) == 1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already completed the catacombs quest.")
            return false
        end
	if player:getStorageValue(45551) <= 5 then
   		player:sendTextMessage(MESSAGE_STATUS_WARNING, "Warning: Enter at your own RISK!") --
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
	end
	if player:getStorageValue(45551) == 6 then
        return true
	end
	
end


