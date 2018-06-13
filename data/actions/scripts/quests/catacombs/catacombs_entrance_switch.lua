
        local storage = 45551
        local playerPosition = {
			Position(1040, 899, 8)
			}
        local stairPos = {
           [1] = {x=1038, y=900, z=7, stackpos=0}, --stairs down 3220
           [2] = {x=1038, y=900, z=8, stackpos=1}  --stairs up   3688
            }

        local time_ = 5 -- seconds

        function onUse(player, item, fromPosition, target, toPosition, isHotkey)
            local function reset()
                item:transform(1945)
                for _, pos in ipairs(stairPos) do
                   doRemoveItem(getTileThingByPos(pos).uid)
                   Game.createItem(3153, 1, stairPos[1])
                end
            end

           if item.itemid == 1946 then
             player:sendTextMessage(MESSAGE_INFO_DESCR, "Switch is active.")
             return false
           end
           			
			local storePlayers, playerTile = {}

			for i = 1, #playerPosition do
			playerTile = Tile(playerPosition[i]):getTopCreature()
			if not playerTile or not playerTile:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "You have to stand on the tile.")
				return true
			end
			
			if player:getGroup():getAccess() then
				item:transform(1946)
				addEvent(reset, time_ * 1000)
                Game.createItem(3220, 1, stairPos[1])
				Game.createItem(3688, 1, stairPos[2])
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Admin Access.")
			return true
			end
			
           -- transform lever, and add reset
           --[[if player:getStorageValue(storage) ~= 6 then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "Access Denied")]]--
            
            if player:getStorageValue(storage) <= 5 then
				item:transform(1946)
				addEvent(reset, time_ * 1000)
                Game.createItem(3220, 1, stairPos[1])
				Game.createItem(3688, 1, stairPos[2])
				player:sendTextMessage(MESSAGE_STATUS_WARNING, "Warning: Enter at your own RISK!") 
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true            
           elseif player:getStorageValue(storage) <= 6 then
           item:transform(1946)
           addEvent(reset, time_ * 1000)
      
           -- create steps, send message and effect
           Game.createItem(3220, 1, stairPos[1])
           Game.createItem(3688, 1, stairPos[2])
           player:sendTextMessage(MESSAGE_INFO_DESCR, "Access Granted!")
           return true
        end
        storePlayers[#storePlayers + 1] = playerTile
    end
 end       