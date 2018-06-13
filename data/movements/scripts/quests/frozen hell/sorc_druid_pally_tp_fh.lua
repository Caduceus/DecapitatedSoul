local pos = {x = 490, y = 1339, z = 10}

function onStepIn(cid, item, position, fromPosition)
 local player = Player(cid)
    if not player then
        return true
    end
    if isInArray({4,9}, player:getVocation():getBase():getId()) then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You do not have the right vocation to enter!")
				doSendMagicEffect(pos, CONST_ME_POOF)
					
	  else
	if isInArray({1,2,3}, player:getVocation():getBase():getId()) then 
   			doTeleportThing(player, pos)
   			doSendMagicEffect(pos, CONST_ME_TELEPORT)
				

	  else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Something went wrong.")
       end
   end
end