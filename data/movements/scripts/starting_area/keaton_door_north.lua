local wallPos = {
    [1] = {x=991, y=895, z=9, stackpos=2}, --door
    [2] = {x=992, y=896, z=9, stackpos=3} --switch
}

local time_ = 6 -- seconds
local effectPos = Position(991, 895, 9)  

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
   
    local function reset()
     local switchClosed = Game.createItem(1945, 1, wallPos[2])
        -- reset wall
        doRemoveItem(getThingfromPos(wallPos[2]).uid)
        Game.createItem(22577, 1, wallPos[1])
        switchClosed:setActionId(15113)
        effectPos:sendMagicEffect(CONST_ME_POFF)
    end
          
    if player:getStorageValue(Storage.keatonMisson.mission) < 2 then
        return true
    end

    -- if wall is up
    if getTileItemById(wallPos[1], 22577).uid > 0 then
        -- add reset
        addEvent(reset, time_ * 1000)

        -- remove walls, send message
        
        
         for i = 1, #wallPos do
            doRemoveItem(getThingfromPos(wallPos[i]).uid)
        end
        
        local switchOpen = Game.createItem(1946, 1, wallPos[2])
        doRemoveItem(getThingfromPos(wallPos[2]).uid)
        switchOpen:setActionId(15113)
        effectPos:sendMagicEffect(CONST_ME_POFF)
    else
    -- if wall is down
        --player:sendTextMessage(MESSAGE_INFO_DESCR, "The wall is down.")
        return true
    end

    return true
end