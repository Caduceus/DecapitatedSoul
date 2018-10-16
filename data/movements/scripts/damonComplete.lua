function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
 
     if player:getStorageValue(Storage.carrionMission.mission) < 3 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have not completed Damon's quest. Please go back.")
			player:teleportTo(fromPosition, false)
        return true
	elseif player:getStorageValue(Storage.carrionMission.mission) == 3 then
				player:addExperience(50, true)
				player:setStorageValue(Storage.carrionMission.mission, 4)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
            return true
	end
end
