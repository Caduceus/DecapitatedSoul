local pos = {x = 394, y = 52, z = 6}

function onStepIn(cid, item, position, fromPosition)
 local player = Player(cid)
    if not player then
        return true
    end
    if isInArray({4,9}, player:getVocation():getBase():getId()) then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You do not have the right vocation to enter!")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
	  else
	if isInArray({1,2,3}, player:getVocation():getBase():getId()) then 
			player:addItem(24774, 1)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have completed the Catacombs Quest!")
            player:teleportTo(pos)
   			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
   			addEvent(broadcastMessage, 15 * 1000, "Congratulations to ".. player:getName() .." for completing the Catacombs Quest", MESSAGE_STATUS_WARNING)
				

	  else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
   end
end