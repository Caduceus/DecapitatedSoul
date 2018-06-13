local stairPos = {
           [1] = {x=1120, y=927, z=9, stackpos=1},
           [2] = {x=1120, y=928, z=9, stackpos=1}
        }

        local time_ = 300 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()
                -- reset switch
                item:transform(1945)
                -- remove stairs
                for _, pos in ipairs(stairPos) do
                   doRemoveItem(getTileThingByPos(pos).uid)
                end
            end

           -- check if lever is currently used
           if item.itemid == 1946 then
             player:sendTextMessage(MESSAGE_INFO_DESCR, "Switch is active.")
             return false
           end
      
           -- transform lever, and add reset
           item:transform(1946)
           addEvent(reset, time_ * 1000)
      
           -- create steps, send message and effect
           Game.createItem(8378, 1, stairPos[1])
           Game.createItem(8379, 1, stairPos[2])
           player:sendTextMessage(MESSAGE_INFO_DESCR, "Access Granted!")
           return true
    end
        