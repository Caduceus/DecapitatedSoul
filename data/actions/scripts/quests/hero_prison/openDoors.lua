 
 --uId: 9016?
 --gates are in counterclockwise order (starting 12 o'clock)
  local gatePos = {
        [1] = {x=1024, y=1132, z=10, stackpos=2}, --removes gate
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

        local time_ = 30 -- seconds 600 10 min
        local bossOpen = 15
        local clearRoom = 30
        local centerPosition = Position(1023, 1139, 10)
        local exitPosition = Position(1020, 1128, 10)

    function onUse(player, item, fromPosition, target, toPosition, isHotkey)
        
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
			
	local function removeMobs()
    local spectators, spectator = Game.getSpectators(centerPosition, false, false, 10, 10, 6, 10)
		for i = 1, #spectators do
			spectator = spectators[i]
			if spectator:isPlayer() then
				spectator:teleportTo(exitPosition)
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
            item:transform(9826)
            addEvent(reset, time_ * 1000)
            addEvent(bossCell, bossOpen * 1000)
            addEvent(removeMobs, clearRoom * 1000)
			doRemoveItem(getThingfromPos(gatePos[2]).uid)
			doRemoveItem(getThingfromPos(gatePos[4]).uid)
			doRemoveItem(getThingfromPos(gatePos[5]).uid)
			doRemoveItem(getThingfromPos(gatePos[6]).uid)
			doRemoveItem(getThingfromPos(gatePos[7]).uid)
			doRemoveItem(getThingfromPos(gatePos[8]).uid)
			
            -- remove walls, send message
            Game.createItem(22577, 1, gatePos[1])
            player:sendTextMessage(MESSAGE_STATUS_WARNING, "Prepare for you're demise!")
            return true
        end
