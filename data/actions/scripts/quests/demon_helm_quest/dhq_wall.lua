  local wallPos = {
            [1] = {x=697, y=709, z=8, stackpos=1},
            [2] = {x=697, y=708, z=8, stackpos=1},
            [3] = {x=704, y=701, z=8, stackpos=1},--3454
            [4] = {x=705, y=701, z=8, stackpos=1},--3454
            [5] = {x=711, y=709, z=8, stackpos=1},
            [6] = {x=711, y=708, z=8, stackpos=1},
            [7] = {x=704, y=711, z=8, stackpos=1} --3454
        }
        
  local centerDemonRoomPosition = Position(704, 699, 8)
  
  local orshPos = {
			[1] = {x=704, y=689, z=8}
		}
        
  local demonPos = {
			[1] = {x=685, y=709, z=8},
			[2] = {x=722, y=709, z=8},
			[3] = {x=704, y=698, z=8},
			[4] = {x=702, y=708, z=8},
			[5] = {x=706, y=708, z=8},
			[6] = {x=704, y=710, z=8}
		}
		
  local bansheePos = {
			[1] = {x=685, y=708, z=8},
			[2] = {x=688, y=708, z=8},
			[3] = {x=693, y=706, z=8},
			[4] = {x=694, y=710, z=8},
			[5] = {x=703, y=694, z=8},
			[6] = {x=705, y=695, z=8},
			[7] = {x=702, y=699, z=8},
			[8] = {x=706, y=699, z=8},
			[9] = {x=714, y=706, z=8},
			[10] = {x=714, y=710, z=8},
			[11] = {x=719, y=708, z=8},
			[12] = {x=722, y=708, z=8},
			[13] = {x=704, y=702, z=8},
			[14] = {x=701, y=705, z=8},
			[15] = {x=707, y=705, z=8},
			[16] = {x=704, y=707, z=8},
			[17] = {x=701, y=710, z=8},
			[18] = {x=707, y=710, z=8},
			[19] = {x=700, y=712, z=8},
			[20] = {x=704, y=712, z=8},
			[21] = {x=707, y=712, z=8}
		}

        local time_ = 180 -- seconds

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
                    Game.createItem(3454, 1, wallPos[7])
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
            
            for _, pos in ipairs(orshPos) do
				doSummonCreature("Orshabaal", pos, false, false)
				doSendMagicEffect(pos, CONST_ME_ENERGYAREA)
			end
            
            for _, pos in ipairs(demonPos) do
				doSummonCreature("Demon", pos, false, false)
				doSendMagicEffect(pos, CONST_ME_ENERGYAREA)
			end
            
             for _, pos in ipairs(bansheePos) do
				doSummonCreature("Banshee", pos, false, false)
				doSendMagicEffect(pos, CONST_ME_ENERGYAREA)
			end
            
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Reward Chamber is now open!")
            return true
        end
