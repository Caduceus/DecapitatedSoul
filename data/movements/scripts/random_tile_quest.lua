local pos = {
    [1] =  {x = 111111, y = 111111, z = 111},
    [2] =  {x = 111111, y = 111111, z = 111},
    [3] =  {x = 111111, y = 111111, z = 111},
    -- this will be the destination they are teleported to when they exit the areana
    [4] =  {x = 111111, y = 111111, z = 111}
}
-- Chooses from a random boss: Cat Mage (May need to redo dmg per spell)
local monsters = {
    [1] =  {"rat"},
    [2] =  {"cave rat"},
    [3] =  {"dragon"}
}

local roomStorageBase = 18000

-- this guarantees they don't enter the same room twice
function returnRandom(cid, pos, storage)
    local value = math.random(1, #pos - 1)
    local randomPosition = pos[value]
    if getPlayerStorageValue(cid, storage + value)  < 0 then
        setPlayerStorageValue(cid, storage + value, 1)
        return randomPosition
    end
    returnRandom(cid, pos, storage)
end

function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then
        return false
    end
    -- teleport random position
    local randP = returnRandom(cid, pos, roomStorageBase)
    doTeleportThing(cid, randP)

    -- area around the random position
    local topLeft = {x = randP.x - 5, y = randP.y + 4, z = randP.z}
    local botRight = {x = randP.x + 5, y = randP.y - 4, z = randP.z}

    -- choose random monster
    local randM = monsters[math.random(1, #monsters)]

    -- spawn 8 of selected random monster in area around random position
    for var = 1, 8 do
        doCreateMonster(randM, math.random(topLeft, botRight))
    end

    return true
end

function onStepOut(cid, item, position, fromPosition)
    if isPlayer(cid) then
        local count = 0
        -- we are subtracting 1 because of the last coordinate in pos is for the destination on exit
        local positions = #pos - 1
        -- see if the player had all the storage values set to 1
        for i = 1, positions do
            count = count + getPlayerStorageValue(cid, storage + i)
        end
        -- if this is the case reset them
        if count == positions then
            for i = 1, positions do
                setPlayerStorageValue(cid, storage + i, -1)
            end
            -- then teleport them out
            doTeleportThing(cid, pos[#pos])
        end
    end
    return true
end