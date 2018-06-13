local storage = 45555
local wallPos = {
    [1] = {x=1033, y=911, z=7, stackpos=1},
    [2] = {x=1033, y=912, z=7, stackpos=1},
    [3] = {x=1025, y=913, z=7, stackpos=2} --switch
}

local time_ = 6 -- seconds
local effectPos1 = Position(1033, 911, 7)
local effectPos2 = Position(1033, 912, 7)
	

function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
        
    local function reset()
        -- reset wall
        Game.createItem(22578, 1, wallPos[1])
        Game.createItem(22578, 1, wallPos[2])
        doRemoveItem(getThingfromPos(wallPos[3]).uid)
        Game.createItem(9826, 1, wallPos[3])
        effectPos1:sendMagicEffect(CONST_ME_POFF)
        effectPos2:sendMagicEffect(CONST_ME_POFF)
    end
            
    if player:getStorageValue(storage) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Talk to The Gatekeeper for help.")
        return true
    end

    -- if wall is up
    if getTileItemById(wallPos[1], 22578).uid > 0 and getTileItemById(wallPos[2], 22578).uid > 0 then
        -- add reset
        addEvent(reset, time_ * 1000)

        -- remove walls, send message
        for i = 1, #wallPos do
            doRemoveItem(getThingfromPos(wallPos[i]).uid)
        end
        Game.createItem(9825, 1, wallPos[3])
        effectPos1:sendMagicEffect(CONST_ME_POFF)
        effectPos2:sendMagicEffect(CONST_ME_POFF)
        --player:sendTextMessage(MESSAGE_INFO_DESCR, "")
    else
    -- if wall is down
        --player:sendTextMessage(MESSAGE_INFO_DESCR, "The wall is down.")
        return true
    end

    return true
end