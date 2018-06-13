--[[
    .::1-Row Slot Machine::.
          For TFS 1.2
      by Cybermaster (cbrm)
]]--

--    1. FRUITS
TEMP, FRUITS = {
    ['APPLE'] = 2674,    ['BANANA'] = 2676,    ['BERRY'] = 2680,
    ['CHERRY'] = 2679,    ['LEMON'] = 8841,    ['MANGO'] = 5097,
    ['MELON'] = 2682,    ['ORANGE'] = 2675,    ['SKULL'] = 2229,		['PUMPKIN'] = 2683
}, {}

for name, id in pairs(TEMP) do
    _G[name] = id
    table.insert(FRUITS, id)
end

--    2. CONFIGURATION
SETUP = {
    MONEY = 2000, --REQUIRED MONEY(gp) TO PLAY SLOT MACHINE
    TIME = 200, --MILLISECONDS TO SWITCH FRUITS
    LIMIT = 50, --COUNTER TO STOP CHANGING FRUIT IF PLAYER DOESN'T (decreases each SETUP.TIME)
    LEVER = {9825, 9826},
    WIN = {
    -- [FRUITS] = {PRIZE,#PRIZE}]
        --MIXED COMBINATIONS
            --[{SKULL,CHERRY,SKULL}] = {18422,10},
            --[{LEMON,SKULL,LEMON}] = {2160,1},
        --TRIPLE COMBINATIONS
			[{SKULL,SKULL,SKULL}] = {18422,20},
			[{CHERRY,CHERRY,CHERRY}] = {18422,10},
			[{PUMPKIN,PUMPKIN,PUMPKIN}] = {18422,8},
            [{BERRY,BERRY,BERRY}] = {18422,7},
            [{MANGO,MANGO,MANGO}] = {18422,6},
            [{MELON,MELON,MELON}] = {18422,5},
            [{BANANA,BANANA,BANANA}] = {18422,4},
            [{ORANGE,ORANGE,ORANGE}] = {18422,3},
            [{APPLE,APPLE,APPLE}] = {18422,2},
            [{LEMON,LEMON,LEMON}] = {18422,1},
        --ANY COMBINATIONS
			[{CHERRY,SKULL,SKULL}] = {2160,2},
            [{SKULL,SKULL,CHERRY}] = {2160,2},
            [{SKULL,CHERRY,SKULL}] = {2160,1},
			[{SKULL,CHERRY,CHERRY}] = {2152,90},
            [{CHERRY,CHERRY,SKULL}] = {2152,90},
            [{CHERRY,SKULL,CHERRY}] = {2152,9},
            [{CHERRY,PUMPKIN,PUMPKIN}] = {2152,80},
            [{PUMPKIN,PUMPKIN,CHERRY}] = {2152,80},
            [{PUMPKIN,CHERRY,PUMPKIN}] = {2152,8},
            [{CHERRY,BERRY,BERRY}] = {2152,70},
            [{BERRY,BERRY,CHERRY}] = {2152,70},
            [{BERRY,CHERRY,BERRY}] = {2152,7},
            [{CHERRY,MANGO,MANGO}] = {2152,60},
            [{MANGO,MANGO,CHERRY}] = {2152,60},
            [{MANGO,CHERRY,MANGO}] = {2152,6},
            [{CHERRY,MELON,MELON}] = {2152,50},
            [{MELON,MELON,CHERRY}] = {2152,50},
            [{MELON,CHERRY,MELON}] = {2152,5},
            [{CHERRY,BANANA,BANANA}] = {2152,40},
            [{BANANA,BANANA,CHERRY}] = {2152,40},
            [{BANANA,CHERRY,BANANA}] = {2152,4},
            [{CHERRY,ORANGE,ORANGE}] = {2152,30},
            [{ORANGE,ORANGE,CHERRY}] = {2152,30},
            [{ORANGE,CHERRY,ORANGE}] = {2152,3},
            [{CHERRY,APPLE,APPLE}] = {2152,20},
            [{APPLE,APPLE,CHERRY}] = {2152,20},
            [{APPLE,CHERRY,APPLE}] = {2152,2},
            [{CHERRY,LEMON,LEMON}] = {2152,10},
            [{LEMON,LEMON,CHERRY}] = {2152,10},
            [{LEMON,CHERRY,LEMON}] = {2152,1},
            
        },
    MSG = {'Bingo!','Lucky!','Jackpot!','Win!'},
    POS = {    --[LEVER.UNIQUEID] = {direction to row, distance from lever to row, position of lever}
        [6297] = {direction = EAST, distance = 2, pos = Position(1054, 930, 10)},
        [6298] = {direction = EAST, distance = 2, pos = Position(1054, 934, 10)},
        [6299] = {direction = WEST, distance = 2, pos = Position(1074, 1004, 8)},
        [6300] = {direction = WEST, distance = 2, pos = Position(1074, 1008, 8)},
        --[6301] = {direction = EAST, distance = 2, pos = Position(1100, 1007, 10)},
        ---[6302] = {direction = EAST, distance = 2, pos = Position(1100, 1007, 10)},
        ---[6302] = {direction = EAST, distance = 2, pos = Position(1100, 1007, 10)},
    },
}

for lever, row in pairs(SETUP.POS) do 
    local position = row.pos:getNextPosition(row.direction, row.distance)
    for tile = 0, 2 do
        if row.direction % 2 == 0 then
            SETUP.POS[lever][tile+101] = Position(position.x+tile, position.y, position.z, 1)
        else
            SETUP.POS[lever][tile+101] = Position(position.x, position.y+tile, position.z, 1)
        end
    end
end

--    3. FUNCTIONS
MAY_NOT_MOVE = 20155
function mayNotMove(cid, bool)
    Player(cid):setStorageValue(MAY_NOT_MOVE, bool and 1 or -1)
end

function choose(...)
    local arg, ret = {...}
    if type(arg[1]) == 'table' then
        ret = arg[1][math.random(#arg[1])]
    else
        ret = arg[math.random(#arg)]
    end
    return ret
end

local function switchLever(lev) 
    return doTransformItem(lev.uid, lev.itemid == SETUP.LEVER[1] and SETUP.LEVER[2] or SETUP.LEVER[1])
end

local function verifyRow(cid, pos)
    local result = false
    for combo, profit in pairs(SETUP.WIN) do
        if (getTileItemById(pos[101], combo[1]).uid > 0) or (combo[1] == ANY) then
            if (getTileItemById(pos[102], combo[2]).uid > 0) or (combo[2] == ANY) then
                if (getTileItemById(pos[103], combo[3]).uid > 0) or (combo[3] == ANY) then
                    result = true
                    doPlayerAddItem(cid, profit[1], profit[2] or 1, true)
                    doCreatureSay(cid, choose(SETUP.MSG), TALKTYPE_ORANGE_1)
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, 'Congratulations!! You won ' .. profit[2] .. ' ' .. getItemDescriptions(profit[1]).plural ..'!')
                    break
                end
            end
        end
    end

    for tile = 101, 103 do
        doRemoveItem(getTileThingByPos(pos[tile]).uid)
        doSendMagicEffect(pos[tile], result and CONST_ME_GIFT_WRAPS or CONST_ME_EXPLOSIONHIT)
    end

    return not result and doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'You have lost this round of Slots.\n                        Try Again!')
end

local function getDirectionTo(pos1, pos2)
    local dir = SOUTH
    if(pos1.x > pos2.x) then
        dir = WEST
        if(pos1.y > pos2.y) then
            dir = NORTHWEST
        elseif(pos1.y < pos2.y) then
            dir = SOUTHWEST
        end
    elseif(pos1.x < pos2.x) then
        dir = EAST
        if(pos1.y > pos2.y) then
            dir = NORTHEAST
        elseif(pos1.y < pos2.y) then
            dir = SOUTHEAST
        end
    elseif(pos1.y > pos2.y) then
        dir = NORTH
    elseif(pos1.y < pos2.y) then
        dir = SOUTH
    end
    return dir
end

--    4. SCRIPT
function onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if getDirectionTo(player:getPosition(), fromPosition) > 3 then
        return true
    end
 
      local pid = player:getId()
    local function getLever()
        for _, id in ipairs(SETUP.LEVER) do
            local lever = getTileItemById(fromPosition, id)
            if lever.uid > 0 then
                return lever
            end
        end      
    end
 
    if item.actionid == 0 then
        doSetItemActionId(item.uid, 100)
    end
    local function doFruit(pos, id, limit)
        if not player:isPlayer() then
            doSetItemActionId(item.uid, 100)
            for tile = 100, 103 do
                if getTileThingByPos(pos[tile]).uid > 0 then
                    doRemoveItem(getTileThingByPos(pos[tile]).uid)
                end
            end
            return true
        end
     
        if getTileThingByPos(pos[id]).itemid < 1 then
            doSendMagicEffect(pos[id], CONST_ME_POFF)
            local fruit = doCreateItemEx(choose(FRUITS))
            doSetItemActionId(fruit, 100)
            doTileAddItemEx(pos[id], fruit)
        else
            doTransformItem(getTileThingByPos(pos[id]).uid, choose(FRUITS))
        end
     
        if limit < 1 then
            doSendMagicEffect(pos[id], math.random(28, 30))
            doTransformItem(getTileThingByPos(pos[id]).uid, choose(FRUITS))
            switchLever(getLever())
            doSetItemActionId(getLever().uid, getLever().actionid+1)
        elseif getLever().actionid > id then
            doSendMagicEffect(pos[id], math.random(28, 30))
            doTransformItem(getTileThingByPos(pos[id]).uid, choose(FRUITS))
        else
            addEvent(doFruit, SETUP.TIME, pos, id, limit-1)
        end
    end

    if item.actionid == 100 then      
        if not player:removeMoneyNpc(SETUP.MONEY) then
            return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'You need ' .. SETUP.MONEY ..' gps to play Slot Machine.')
        end
     
        doSetItemActionId(item.uid, 101)
        mayNotMove(pid, true)
        switchLever(item)
        player:say('-$' .. SETUP.MONEY, TALKTYPE_ORANGE_1)
        for tile = 101, 103 do
            doFruit(SETUP.POS[item.uid], tile, (tile-100)*SETUP.LIMIT)
        end
    elseif isInArray({101,102,103}, item.actionid) then
        switchLever(item)
        doSetItemActionId(item.uid, item.actionid+1)
    elseif item.actionid == 104 then
        switchLever(item)
        mayNotMove(pid, false)
        verifyRow(pid, SETUP.POS[item.uid])
        doSetItemActionId(item.uid, 100)
    end
    return true
end