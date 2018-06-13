local storage = 45555
local wallPos = {
    [1] = {x=1022, y=910, z=7, stackpos=1},
    [2] = {x=1023, y=913, z=7, stackpos=3} --switch
}

local time_ = 6 -- seconds
local effectPos = Position(1022, 910, 7)  

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
      
    local function reset()
        -- reset wall
        Game.createItem(22578, 1, wallPos[1])
        doRemoveItem(getThingfromPos(wallPos[2]).uid)
        Game.createItem(9825, 1, wallPos[2])
        effectPos:sendMagicEffect(CONST_ME_POFF)
    end
          
    if player:getStorageValue(storage) < 2 then
        --player:sendTextMessage(MESSAGE_INFO_DESCR, "")
        return true
    end

    -- if wall is up
    if getTileItemById(wallPos[1], 22578).uid > 0 then
        -- add reset
        addEvent(reset, time_ * 1000)

        -- remove walls, send message
        
        
        for i = 1, #wallPos do
            doRemoveItem(getThingfromPos(wallPos[i]).uid)
        end
        Game.createItem(9826, 1, wallPos[2])
        effectPos:sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "")
    else
    -- if wall is down
        --player:sendTextMessage(MESSAGE_INFO_DESCR, "The wall is down.")
        return true
    end

    return true
end