local stairPos = {
           [1] = {x=527, y=1294, z=8, stackpos=1},
           [2] = {x=528, y=1294, z=8, stackpos=1}
        }
        
        local time_ = 10 -- seconds

        function onStepIn(cid, item, position, fromPosition)
		 local player = Player(cid)
			if not player then
				return true
				end
            local function reset()
                -- reset switch
                item:transform(965)
                -- remove stairs
                for _, pos in ipairs(stairPos) do
                   doRemoveItem(getTileThingByPos(pos).uid)
                end
            end

           -- check if lever is currently used
           if item.itemid == 966 then
             player:sendTextMessage(MESSAGE_INFO_DESCR, "Steps are active.")
             return false
           end
      
           -- transform lever, and add reset
           item:transform(966)
           addEvent(reset, time_ * 1000)
      
           -- create steps, send message and effect
           Game.createItem(6911, 1, stairPos[1])
           Game.createItem(6912, 1, stairPos[2])
           player:sendTextMessage(MESSAGE_INFO_DESCR, "Hidden Steps! Do you take them?")
           return true
        end