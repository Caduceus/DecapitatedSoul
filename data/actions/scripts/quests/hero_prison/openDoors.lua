 
 --uId: 9016?
 --gates are in counterclockwise order (starting 12 o'clock)
  local gatePos = {
        [1] = {x=1024, y=1136, z=10, stackpos=2}, --removes gate
        [2] = {x=1022, y=1138, z=10, stackpos=2}, 
        [3] = {x=1018, y=1144, z=10, stackpos=2}, --boss cell
        [4] = {x=1020, y=1145, z=10, stackpos=3}, 
        [5] = {x=1024, y=1145, z=10, stackpos=3}, 
        [6] = {x=1028, y=1145, z=10, stackpos=3}, 
        [7] = {x=1029, y=1144, z=10, stackpos=3},
        [8] = {x=1025, y=1139, z=10, stackpos=3}, 
        }
          
  local bossPos = {
			[1] = {x=704, y=689, z=8} --not set
		}

        local time_ = 210 -- seconds 3.5 min
        local bossOpen = 40
        local secondWave = 30
        local clearRoom = 210
        local centerPosition = Position(1023, 1139, 10)
        local exitPosition = Position(1020, 1128, 10)

    function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
    if player:getStorageValue(Storage.heroPrisonSwitch) > os.time() then
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You are a bit weak after that attempt. Come back in 24 hours to retry.")
		return false
	end
    
    -- add cooldown on switch via os.time? check medusa script for example
        
        if player:getLevel() < 80 then
			player:sendTextMessage(MESSAGE_STATUS_WARNING, "You are not strong enough to activate switch.")
			return false
		end

            local function reset()
				item:transform(9825)
                doRemoveItem(getThingfromPos(gatePos[1]).uid)
                Game.createItem(22578, 1, gatePos[2]) 
                Game.createItem(22578, 1, gatePos[3]) -- boss cell
                Game.createItem(22577, 1, gatePos[4])
                Game.createItem(22577, 1, gatePos[5])
                Game.createItem(22577, 1, gatePos[6])
                Game.createItem(22578, 1, gatePos[7]) 
                Game.createItem(22578, 1, gatePos[8]) 
            end
                            
            local function bossCell()
				doRemoveItem(getThingfromPos(gatePos[3]).uid)
			end
			
			local function delayedOpen()
				doRemoveItem(getThingfromPos(gatePos[4]).uid)
				doRemoveItem(getThingfromPos(gatePos[5]).uid)
				doRemoveItem(getThingfromPos(gatePos[6]).uid)
				addEvent(bossCell, bossOpen * 1000) 
			end
			
	local function removeMobs()
    local spectators, spectator = Game.getSpectators(centerPosition, false, false, 10, 10, 2, 10)
		for i = 1, #spectators do
			spectator = spectators[i]
			if spectator:isPlayer() then
				spectator:teleportTo(exitPosition)
				spectator:setDirection(DIRECTION_EAST)
			end

			if spectator:isMonster() then
				spectator:remove()
			end
		end
	end

           -- check if lever is currently used
            if item.itemid == 9826 then
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "The switch is jammed!")
                return false
            end
   
            -- transform lever, and add reset
            player:setStorageValue(Storage.heroPrisonSwitch, os.time() + 24*60*60)
            player:save()
            item:transform(9826)
            addEvent(reset, time_ * 1000)
            addEvent(delayedOpen, secondWave * 1000) 
            addEvent(removeMobs, clearRoom * 1000)
			doRemoveItem(getThingfromPos(gatePos[2]).uid)
			doRemoveItem(getThingfromPos(gatePos[7]).uid)
			doRemoveItem(getThingfromPos(gatePos[8]).uid)
			
            -- remove walls, send message
            Game.createItem(22577, 1, gatePos[1])
            player:sendTextMessage(MESSAGE_STATUS_WARNING, "Prepare for you're demise!")
            return true
        end
