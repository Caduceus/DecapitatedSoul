local storage = 15009
local wallPos = {
    [1] = {x=1227, y=768, z=5, stackpos=1}
}

local time_ = 10 -- 10 seconds

function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
        
    local function reset()
        -- reset wall
        Game.createItem(3492, 1, wallPos[1])
    end
            
    -- check if player has storage
    if player:getStorageValue(storage) < 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You Must Complete the Frozen Hell Quest!")
        player:teleportTo(fromPosition, false)
        doSendMagicEffect(pos, CONST_ME_POOF)
        return true
    end

    -- if wall is up
    if getTileItemById(wallPos[1], 3492).uid > 0 then
        -- add reset
        addEvent(reset, time_ * 1000)

        -- remove walls, send message
        for i = 1, #wallPos do
            item:getPosition():sendMagicEffect(CONST_ME_SOUND_BLUE)
            doRemoveItem(getThingfromPos(wallPos[i]).uid)
        end
        
        player:sendTextMessage(MESSAGE_INFO_DESCR, "It's dangerous out there. Enter at your own risk!")
    else
    -- if wall is down
        --player:sendTextMessage(MESSAGE_INFO_DESCR, "The wall is down.")
        return true
    end

    return true
end