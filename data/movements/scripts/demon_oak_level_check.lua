local config = {
	storage = 15001,
	reqLevel = 150
	}
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
    if item.actionid == 16001 then
     if player:getLevel() < config.reqLevel then
			player:teleportTo(fromPosition, false)
   			player:sendTextMessage(MESSAGE_STATUS_SMALL, "Quest requires level ".. config.reqLevel ..". Come back when you are more worthy!")
				doSendMagicEffect(pos, CONST_ME_POOF)
                return false
            end
         end
      end