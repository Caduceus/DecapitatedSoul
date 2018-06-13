local storage = 15010
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
    if item.actionid == 16015 then
     if player:getStorageValue(storage) < 1 then
			player:setStorageValue(storage, os.time() + 24*60*60)
				doSendMagicEffect(pos, CONST_ME_POOF)
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Storage set")
                return true
            end
         end
      end
