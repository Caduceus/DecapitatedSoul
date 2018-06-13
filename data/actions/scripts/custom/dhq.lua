  local wallPos = {
            [1] = {x=596, y=956, z=15, stackpos=1},
            [2] = {x=596, y=955, z=15, stackpos=1},
            [3] = {x=603, y=948, z=15, stackpos=1},
            [4] = {x=604, y=948, z=15, stackpos=1},
            [5] = {x=610, y=955, z=15, stackpos=1},
            [6] = {x=610, y=956, z=15, stackpos=1}
        }
        
        local demonPos = {
			[1] = {x=582, y=1008, z=9},
			[2] = {x=593, y=999, z=9},
			[3] = {x=604, y=1008, z=9}
		}

        local time_ = 120 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()
                -- reset switch
            item:transform(1945)
                -- reset walls
                    Game.createItem(3463, 1, wallPos[1])
                    Game.createItem(3463, 1, wallPos[2])
                    Game.createItem(3454, 1, wallPos[3])
                    Game.createItem(3454, 1, wallPos[4])
                    Game.createItem(3463, 1, wallPos[5])
                    Game.createItem(3463, 1, wallPos[6])
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
            
            for _, pos in ipairs(demonPos) do
				doSummonCreature("Demon", pos, false, false)
				doSendMagicEffect(pos, CONST_ME_ENERGYAREA)
			end
            
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Reward Chamber is now open!")
            return true
        end
        