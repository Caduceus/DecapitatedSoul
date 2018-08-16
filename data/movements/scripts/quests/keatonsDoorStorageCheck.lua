function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    --if item.actionid == 16004 then
		if player:getStorageValue(Storage.keatonMisson.mission) < 2 then
			player:teleportTo(fromPosition, false)
   			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Keaton has put a forcefield on the entrance. You may not enter!")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        --end
    end
end