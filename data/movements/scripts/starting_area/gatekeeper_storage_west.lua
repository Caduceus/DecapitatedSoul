function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    if item.actionid == 16004 then
		if player:getStorageValue(45555) < 2 then
			player:teleportTo(fromPosition, false)
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have not completed the quest!")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        end
    end
end