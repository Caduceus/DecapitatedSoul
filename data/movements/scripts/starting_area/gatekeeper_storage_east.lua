function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    if item.actionid == 16019 then
		if player:getStorageValue(45555) < 1 then
			player:teleportTo(fromPosition, false)
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have not started the quest!")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        end
    end
end