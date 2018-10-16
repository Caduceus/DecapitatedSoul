local pos1 = {x = 394, y = 52, z = 6} --sorc_druid_pally
local pos2 = {x = 392, y = 48, z = 7} --knight_temp

function onStepIn(cid, item, position, fromPosition)
 local player = Player(cid)
    if not player then
        return true
    end
    if isInArray({1,2,3}, player:getVocation():getBase():getId()) then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have completed the Catacombs Quest!")
            player:teleportTo(pos1)
            player:setStorageValue(Storage.sorayaMission.stormblast, 1)
   			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	 elseif isInArray({4,9}, player:getVocation():getBase():getId()) then 
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have completed the Catacombs Quest!")
            player:teleportTo(pos2)
            player:setStorageValue(Storage.sorayaMission.stormblast, 1)
   			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
   end
end
