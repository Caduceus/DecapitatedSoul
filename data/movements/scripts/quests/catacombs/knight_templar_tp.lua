local pos = {x = 392, y = 48, z = 7}

function onStepIn(cid, item, position, fromPosition)
 local player = Player(cid)
    if not player then
        return true
    end
    if isInArray({1,2,3}, player:getVocation():getBase():getId()) then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You do not have the right vocation to enter!")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
	 elseif isInArray({4,9}, player:getVocation():getBase():getId()) then 
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have completed the Catacombs Quest!")
            player:teleportTo(pos)
            player:setStorageValue(Storage.sorayaMission.stormblast, 1)
   			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
   end
end
