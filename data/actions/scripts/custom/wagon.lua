local config = {
    speed = {wagonSpeed = 100, playerSpeed = 1000},
    wagonStorage = 3000,
    wagonActionId = 5000, -- North = 5000, EAST = 5001, SOUTH = 5002, WEST = 5003
    wagonDirection = {[DIRECTION_NORTH] = 7132, [DIRECTION_EAST] = 7131, [DIRECTION_SOUTH] = 7132, [DIRECTION_WEST] = 7131},
    railDirection = {
        [7123] = {DIRECTION_EAST, DIRECTION_SOUTH},
        [7124] = {DIRECTION_WEST, DIRECTION_SOUTH},
        [7125] = {DIRECTION_EAST, DIRECTION_NORTH},
        [7126] = {DIRECTION_WEST, DIRECTION_NORTH},
        [7128] = {DIRECTION_WEST, DIRECTION_SOUTH}
    }
}

local function getRail(position)
    local tile = Tile(position)
    if tile then
        -- Loop through items
        for _, item in ipairs(tile:getItems()) do
            -- We found rail, return id
            if isInArray({459, 7121, 7122, 7123, 7124, 7125, 7126, 7127, 7128, 7129, 7130}, item:getId()) then
                return item:getId()
            end
        end
    end

    return 0
end

local outfitCondition = Condition(CONDITION_OUTFIT, CONDITIONID_COMBAT)
outfitCondition:setTicks(-1)

local function moveWagon(cid, direction)
    local player = Player(cid)
    if not player then
        return
    end

    -- If there is no rail, just stop the wagon
    local position = player:getPosition()
    local getRail = getRail(position)
    if getRail == 0 then
        -- Remove Outfit
        player:removeCondition(CONDITION_OUTFIT, CONDITIONID_COMBAT)

        -- Remove speed
        player:changeSpeed(-config.speed.playerSpeed)

        -- Remove Storage
        player:setStorageValue(config.wagonStorage, 0)

        -- Teleport 1 sqm forward and make sure it's not a blocking item
        position:getNextPosition(direction)
        position = player:getClosestFreePosition(position, false)
        player:teleportTo(position, true)
        return
    end

    -- Handle new rail directions
    local newRail = config.railDirection[getRail]
    if newRail and type(newRail) == 'table' then
        direction = newRail[newRail[1] == Game.getReverseDirection(direction) and 2 or 1]
        outfitCondition:setOutfit(config.wagonDirection[direction])
        player:addCondition(outfitCondition)
    end

    -- Handle movement
    doMoveCreature(cid, direction)
    addEvent(moveWagon, config.speed.wagonSpeed, cid, direction)
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Teleport into the wagon
    player:teleportTo(toPosition, true)

    -- Get direction by action id
    local direction = item.actionid - config.wagonActionId

    -- Set Outfit, according the direction and set it
    outfitCondition:setOutfit(config.wagonDirection[direction])
    player:addCondition(outfitCondition)
    player:setDirection(direction)

    -- Change Speed
    player:changeSpeed(config.speed.playerSpeed)

    -- Set Storage
    player:setStorageValue(config.wagonStorage, 1)

    -- Move the wagon
    moveWagon(player:getId(), direction)
    return true
end
