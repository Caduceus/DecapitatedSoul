local storage = Storage.carrionMission.mission
function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
 
    if item.actionid == 16008 then
     if player:getStorageValue(Storage.carrionMission.mission) < 3 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have not completed Damon's quest. You may not enter.")
				player:teleportTo(fromPosition, false)
                return true
			end
		end
	
	local player = Player(cid)
    if not player then
        return true
    end	
    if item.actionid == 16008 then
     if player:getStorageValue(Storage.carrionMission.mission) == 4 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You are almost there! Soraya is just Northwest of here. Inside the shops beside Eryn.")
				player:addExperience(200, true)
				player:setStorageValue(Storage.carrionMission.mission, 5)
				player:setTown(Town(1))
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
                return true
            end

    else
    if item.actionid == 16009 then
     if player:getStorageValue(Storage.carrionMission.mission) == 5 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "Well done! You may now continue your journeys, ".. player:getName() ..".")
				player:addExperience(200, true)
				player:setStorageValue(Storage.carrionMission.mission, 6)
                return true
            end
         end
     end
 end