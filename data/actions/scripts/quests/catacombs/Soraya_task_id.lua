local time_ = 2 -- seconds

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local function reset()
            item:transform(5135)
         end
		if player:getGroup():getAccess() then
			item:transform(5136)
			addEvent(reset, time_ * 1000)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Admin Access.")
			return true
		end
        if item.itemid == 5136 then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "The door is already open.")
                return false
        end
        
        if player:getLevel() < 50 then
			player:sendTextMessage(MESSAGE_STATUS_WARNING, "Warning: This area is not setup for a player of your level.")
			return true
		end
            
        if player:getStorageValue(15001) == 1 or player:getStorageValue(45551) == 7 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already completed the catacombs quest.")
            return false
        end
        
		if player:getStorageValue(45551) <= 6 then 
			item:transform(5136)
			addEvent(reset, time_ * 1000)            
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Entrance is now open!")
			return true
		end
end
