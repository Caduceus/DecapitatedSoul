local stairPos = {
           [1] = {x=549, y=1239, z=8, stackpos=2}
        }
        
 local wallPos = {
            [1] = {x=545, y=1241, z=8, stackpos=3}
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
				   Game.createItem(6744, 1, wallPos[1])
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
           for i = 1, #wallPos do
                doRemoveItem(getThingfromPos(wallPos[i]).uid)
            end
           Game.createItem(1386, 1, stairPos[1])
           player:sendTextMessage(MESSAGE_INFO_DESCR, "Hidden passage! Do you take it?")
           return true
        end