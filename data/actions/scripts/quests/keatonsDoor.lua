  local wallPos = {
            [1] = {x=991, y=895, z=9, stackpos=2},
        }
        local time_ = 5 -- seconds
        local effectPos = Position(991, 895, 9)  

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()
            
                -- reset switch
            item:transform(1945)
                -- reset walls
                    Game.createItem(22577, 1, wallPos[1])
                    effectPos:sendMagicEffect(CONST_ME_POFF)
                end

           -- check if lever is currently used
            if item.itemid == 1946 then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Switch is already active.")
                return false
            end
            
            if player:getStorageValue(Storage.keatonMisson.mission) < 2 then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Keaton has this door locked.")
				return true
			end
   
            -- transform lever, and add reset
            item:transform(1946)
            addEvent(reset, time_ * 1000)
   
            for i = 1, #wallPos do
                doRemoveItem(getThingfromPos(wallPos[1]).uid)
            end
                        
            player:sendTextMessage(MESSAGE_INFO_DESCR, "The wagon entrance is now open!")
            return true
        end
