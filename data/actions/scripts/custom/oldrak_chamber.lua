
        local storage = 45556
        local stairPos = {
           [1] = {x=972, y=1140, z=7, stackpos=1}    
            }

        local time_ = 5 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()

                -- reset switch
                item:transform(2058)
                -- remove stairs
                for _, pos in ipairs(stairPos) do
                   doRemoveItem(getTileThingByPos(pos).uid)
                   Game.createItem(7522, 1, stairPos[1])
                end
            end

           -- check if lever is currently used
           if item.itemid == 2059 then
             player:sendTextMessage(MESSAGE_INFO_DESCR, "Switch is active.")
             return false
           end
      
           -- transform lever, and add reset
           if player:getStorageValue(storage) < 5 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Must complete 'Lilith's - Reign of Terror:Demon' Quest.")
            
           elseif player:getStorageValue(storage) >= 5 then
           item:transform(2059)
           addEvent(reset, time_ * 1000)
            for i = 1, #stairPos do
                doRemoveItem(getThingfromPos(stairPos[i]).uid)
      
           -- create steps, send message and effect
           Game.createItem(7524, 1, stairPos[1])
           player:sendTextMessage(MESSAGE_INFO_DESCR, "A hidden passage!")
           return true
            end
        end
     end 
        