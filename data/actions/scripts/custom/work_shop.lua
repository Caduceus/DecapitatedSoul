local storage = 666
        local stairPos = {
           [1] = {x=1077, y=1001, z=8, stackpos=0},
           [2] = {x=1077, y=1001, z=8, stackpos=1}     
            }

        local time_ = 10 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()

                -- reset switch
                item:transform(15127)
                -- remove stairs
                for _, pos in ipairs(stairPos) do
                   doRemoveItem(getTileThingByPos(pos).uid)
                   Game.createItem(23259, 1, stairPos[2])
                end
            end

           -- check if lever is currently used
           if item.itemid == 15128 then
             player:sendTextMessage(MESSAGE_INFO_DESCR, "Switch is active.")
             return false
           end
      
           -- transform lever, and add reset
           if player:getStorageValue(storage) < 1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Access Denied")
            
           elseif player:getStorageValue(storage) == 1 then
           item:transform(15128)
           addEvent(reset, time_ * 1000)
      
           -- create steps, send message and effect
           Game.createItem(433, 1, stairPos[1])
           player:sendTextMessage(MESSAGE_INFO_DESCR, "Access Granted!")
           return true
        end
     end