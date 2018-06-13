local config = {
	pushBackPosition = Position(635, 1436, 6),
	reqLevel = 225
	}
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
    if item.actionid == 16002 then
     if player:getLevel() < config.reqLevel then
   			player:sendTextMessage(MESSAGE_STATUS_SMALL, "This area requires ".. config.reqLevel ..". Leave here at once!")
				player:teleportTo(config.pushBackPosition)
				doSendMagicEffect(pos, CONST_ME_POOF)
                return false
            end
         end
      end