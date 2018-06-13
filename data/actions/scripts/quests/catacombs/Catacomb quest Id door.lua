local storage = 15001
local pos = {x = 1033, y = 1028, z = 15}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(storage) < 1 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You must complete Catacombs Quest!")
				doSendMagicEffect(pos, CONST_ME_POOF)
					
	  else
	if player:getStorageValue(storage) >= 1 then 
   			doTeleportThing(player, pos)
   			doSendMagicEffect(pos, CONST_ME_TELEPORT)
				

	  else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
   end
end


