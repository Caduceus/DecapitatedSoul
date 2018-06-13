local storage = 45551
local pos = {x = 1228, y = 1103, z = 9}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(15001) == 1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already completed the catacombs quest.")
            return true
        end
        
    if player:getStorageValue(storage) <= 5 then	  
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You must be on the last of Soraya's Tasks to enter!")
    
    else   
	if player:getStorageValue(storage) == 6 then 
   			doTeleportThing(player, pos)
   			doSendMagicEffect(pos, CONST_ME_TELEPORT)
   			
   	else
       player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
   end
end