local storage = 15001
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
    if item.actionid == 16003 then
     if player:getStorageValue(storage) < 1 then
			player:teleportTo(fromPosition, false)
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You must complete the Catacombs Quest to enter!")
				doSendMagicEffect(pos, CONST_ME_POOF)
                return false
            end
         end
      end