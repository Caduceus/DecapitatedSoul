local storage = Storage.thievesGuild.Quest
        local stairPos = {
           [1] = {x=1274, y=1139, z=5, stackpos=0},
           [2] = {x=1272, y=1139, z=5, stackpos=1}     
            }

        local time_ = 10 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()

                -- reset switch
                item:transform(19690)
                -- remove stairs
                for _, pos in ipairs(stairPos) do
                   doRemoveItem(getTileThingByPos(stairPos[1]).uid)
                   Game.createItem(9224, 1, stairPos[1])
                end
            end

           -- check if lever is currently used
           if item.itemid == 19689 then
             player:sendTextMessage(MESSAGE_INFO_DESCR, "Switch is active.")
             return false
           end
      
           -- transform lever, and add reset
           if player:getStorageValue(storage) < 1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Lamp is broken")
            
           elseif player:getStorageValue(storage) >= 1 then
           item:transform(19689)
           addEvent(reset, time_ * 1000)
      
           -- create steps, send message and effect
           Game.createItem(410, 1, stairPos[1])
           player:sendTextMessage(MESSAGE_INFO_DESCR, "Access Granted!")
           return true
        end
     end
     