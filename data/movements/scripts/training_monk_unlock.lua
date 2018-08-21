local storage = 45551
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
 
     if player:getStorageValue(storage) < 2 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You must first show your loyalty to Soraya. You may not enter!")
				player:teleportTo(fromPosition, false)
            return true
		end
	end
