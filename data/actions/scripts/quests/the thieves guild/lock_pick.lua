function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local time_ = 5 -- seconds
	local function reset()
		target:transform(25291)
    end
    --[[if player:getStorageValue(1212) <= 1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You do not know how to properly use this item and have broken the pick in the attempt.")
		Item(item.uid):remove(1)
    return true
end]]--
    
    local chance = math.random (1,10)
        if item.itemid == 8717 and target:getActionId() == 1212 then
                if chance <= 7 then
                    target:transform(25292)
                    addEvent(reset, time_ * 1000)
                    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "The door has been unlocked!")
                    else
                    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You failed to pick the lock and have broken your pick in the attempt.")
                    Item(item.uid):remove(1)
            end
        end
        return true
    end
    