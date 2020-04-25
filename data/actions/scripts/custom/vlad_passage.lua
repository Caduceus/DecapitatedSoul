  local storage = 666 
  --action id 15109 does it slide over or swing 
  local wallPos = {
            [1] = {x=965, y=1035, z=10, stackpos=2},
            [2] = {x=965, y=1036, z=10, stackpos=1}, --piano start pos
            [3] = {x=964, y=1036, z=10, stackpos=1} --piano open pos
        }

        local time_ = 5 -- 5 seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()
                 -- reset switch
            local piano = Game.createItem(2080, 1, wallPos[2])
                -- reset walls
					doRemoveItem(getThingfromPos(wallPos[3]).uid)
                    Game.createItem(9119, 1, wallPos[1])
                    piano:setActionId(15109)
                end
                
                -- check if lever is currently used
            --[[if player:getStorageValue(storage) < 1 then
   			player:sendTextMessage(MESSAGE_INFO_DESCR, "You must complete Catacombs Quest!")
				doSendMagicEffect(pos, CONST_ME_POOF)
                return false
             end]]--

            -- add reset
            addEvent(reset, time_ * 1000)
   
            -- remove walls, send message
            for i = 1, #wallPos do
            item:getPosition():sendMagicEffect(CONST_ME_SOUND_BLUE)
				doRemoveItem(getThingfromPos(wallPos[2]).uid)
                doRemoveItem(getThingfromPos(wallPos[i]).uid)
            end
			Game.createItem(2080, 1, wallPos[3])
            player:setStorageValue(123075, os.time() + 5)
			player:save()
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Hurry, the door is closing!")
            return true
        end
        