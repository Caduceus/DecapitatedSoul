  local wallPos = {
            [1] = {x=1095, y=991, z=8, stackpos=1}, --22578
            [2] = {x=1095, y=992, z=8, stackpos=1},
            [3] = {x=1095, y=996, z=8, stackpos=1},
            [4] = {x=1095, y=997, z=8, stackpos=1}  
        }
        

       local time_ = 10 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
        
            local function reset() --reset walls
            item:transform(1946)
                    Game.createItem(22578, 1, wallPos[1])
                    Game.createItem(22578, 1, wallPos[2])
                    Game.createItem(22578, 1, wallPos[3])
                    Game.createItem(22578, 1, wallPos[4])                
                end

            if item.itemid == 1945 then --
				item:transform(1946)
					Game.createItem(22578, 1, wallPos[1])
                    Game.createItem(22578, 1, wallPos[2])
                    Game.createItem(22578, 1, wallPos[3])
                    Game.createItem(22578, 1, wallPos[4])
                player:sendTextMessage(MESSAGE_INFO_DESCR, "closed.")
                return true
            end
   
            -- transform lever, and add reset
            item:transform(1945)
           -- addEvent(reset, time_ * 1000)
   
            -- remove walls, send message
            --[[
                1st getThingfromPos is called and passed a wallPos at the index of i, the item is return and then we ask for
                one of it's properties in this case its uid, when then pass that to reRemoveItem, which removes the item
            ]]
            for i = 1, #wallPos do
                doRemoveItem(getThingfromPos(wallPos[i]).uid)
            end
            
            
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Testing arena is open.")
            return true
        end
        