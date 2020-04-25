  local storage = 666 
  --action id 15109 does it slide over or swing 
  local wallPos = {
            [1] = {x=965, y=1035, z=10, stackpos=2},
            [2] = {x=965, y=1036, z=10, stackpos=1}, --piano start pos
            [3] = {x=964, y=1036, z=10, stackpos=1} --piano open pos
        }

    local time_ = 5 -- 5 seconds
	local pushBackPosition = Position(965, 1037, 10)
	
function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
		if not player then
			return true
		end
				
	if player:getStorageValue(123075) >= os.time() then
		return false
	end
			
    local function reset()
    -- reset switch
    local piano = Game.createItem(2080, 1, wallPos[2])
    -- reset walls
		doRemoveItem(getThingfromPos(wallPos[3]).uid)
        Game.createItem(9119, 1, wallPos[1])
        piano:setActionId(15109)
    end
                
    -- add reset
        addEvent(reset, time_ * 1000)
    -- remove walls, send message
    for i = 1, #wallPos do
		doRemoveItem(getThingfromPos(wallPos[2]).uid)
        doRemoveItem(getThingfromPos(wallPos[i]).uid)
    end
		Game.createItem(2080, 1, wallPos[3])
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Poop Coon!!!")
    return true
end
        