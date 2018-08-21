local pos = {x = 394, y = 52, z = 6}

function onStepIn(cid, item, position, fromPosition)
 local player = Player(cid)
    if not player then
        return true
    end
    if isInArray({4,9}, player:getVocation():getBase():getId()) then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You do not have the right vocation to enter!")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
	  elseif isInArray({1,2,3}, player:getVocation():getBase():getId()) then 
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have completed the Catacombs Quest!")
            player:teleportTo(pos)
   			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
   end
end
