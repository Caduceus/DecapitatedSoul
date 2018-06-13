  local storage = 15001
  local wallPos = {
            [1] = {x=1024, y=926, z=9, stackpos=2}
        }

        local time_ = 5 -- 5 seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()
                 -- reset switch
            item:transform(2080)
                -- reset walls
                    Game.createItem(9119, 1, wallPos[1])
                end
                
                -- check if lever is currently used
            if player:getStorageValue(storage) < 1 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You must complete Catacombs Quest!")
				doSendMagicEffect(pos, CONST_ME_POOF)
                return false
             end
            -- If door is open, then can not reuse again while open.
             if item.itemid == 2082 then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "It Will Not Budge.")
                return false
                end

            -- add reset
            item:transform(2082)
            addEvent(reset, time_ * 1000)
   
            -- remove walls, send message
            for i = 1, #wallPos do
            item:getPosition():sendMagicEffect(CONST_ME_SOUND_BLUE)
                doRemoveItem(getThingfromPos(wallPos[i]).uid)
            end
            
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Hurry, the door is closing!")
            return true
        end
        
        