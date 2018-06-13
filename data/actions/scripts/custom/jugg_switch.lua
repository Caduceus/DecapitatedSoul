  local wallPos = {
            [1] = {x=1328, y=824, z=5, stackpos=1},
            [2] = {x=1329, y=824, z=5, stackpos=1},
        }

        local time_ = 10 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()
                -- reset switch
            item:transform(1945)
                -- reset walls
                    Game.createItem(3455, 1, wallPos[1])
                    Game.createItem(3455, 1, wallPos[2])               
                end
                
           -- check if player has required level.
		   if player:getLevel() < 180 then
		   return player:sendTextMessage(MESSAGE_STATUS_WARNING,"Switch requires level 150 to use.")
		   end

           -- check if lever is currently used
            if item.itemid == 1946 then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Switch is already active.")
                return false
            end
   
            -- transform lever, and add reset
            item:transform(1946)
            addEvent(reset, time_ * 1000)
   
            -- remove walls, send message
            --[[
                1st getThingfromPos is called and passed a wallPos at the index of i, the item is return and then we ask for
                one of it's properties in this case its uid, when then pass that to reRemoveItem, which removes the item
            ]]
            for i = 1, #wallPos do
                doRemoveItem(getThingfromPos(wallPos[i]).uid)
            end
            
            
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Entrance is now open!")
            return true
        end
        
        