local storage = 45557
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
 
    if item.actionid == 16010 then
     if player:getStorageValue(storage) < 2 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have not completed Keaton's quest. You may not enter.")
				player:teleportTo(fromPosition, false)
                return true
			end
else	
    if item.actionid == 16010 then
     if player:getStorageValue(storage) >= 2 then
				player:addExperience(50, true)
				player:setStorageValue(storage, 3)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                return true
            end
		end
	end
end
