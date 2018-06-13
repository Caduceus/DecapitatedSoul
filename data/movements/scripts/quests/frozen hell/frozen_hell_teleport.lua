local config = {
	storage = 15009,
	quest_storage = 45556,
	pos = {x = 493, y = 1369, z = 6},
	pushBackPosition = Position(547, 1289, 8)
	}

function onStepIn(cid, item, position, fromPosition)
 local player = Player(cid)
    if not player then
        return true
    end
    
    if player:getStorageValue(config.storage) < 1 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Good luck!")
			doTeleportThing(player, config.pos)
   			doSendMagicEffect(pos, CONST_ME_TELEPORT)
   			
	 else
	if player:getStorageValue(config.quest_storage) < 10 then 
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "Your soul is not yet attuned to an evil of this caliber!")
				player:teleportTo(config.pushBackPosition)
				doSendMagicEffect(pos, CONST_ME_POOF)
					
	  else
	if player:getStorageValue(config.storage) >= 1 then 
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already completed this section of Frozen Hell!")
				player:teleportTo(config.pushBackPosition)
				doSendMagicEffect(pos, CONST_ME_POOF)
				

	  else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
           end
       end
   end
end


