local config = {
	reqLevel = 120,
	storage = 15107, 
	playerDestination = Position(1132, 817, 6)
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid == 8834 then
        if item.uid ~= 15107 then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_CANNOTUSETHISOBJECT))
            return true
        end
        
        if player:getLevel() < config.reqLevel then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Switch requires level ".. config.reqLevel ..".")
            return true
        end
					
	 player:teleportTo(config.playerDestination, false)
	 player:getPosition():sendMagicEffect(CONST_ME_STUN)
     player:sendTextMessage(MESSAGE_INFO_DESCR, "Hunt or be hunted!")
end
end

