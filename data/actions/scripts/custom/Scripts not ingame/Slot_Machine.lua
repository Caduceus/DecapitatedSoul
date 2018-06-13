--[[
    .::1-Row Slot Machine::.
          For TFS 1.0
      by Cybermaster (cbrm)
]]--

--    1. FRUITS
TEMP, FRUITS = {
    ['APPLE'] = 2674,    ['BANANA'] = 2676,    ['BERRY'] = 2680,
    ['CHERRY'] = 2679,    ['LEMON'] = 8841,    ['MANGO'] = 5097,
    ['MELON'] = 2682,    ['ORANGE'] = 2675,    ['PUMPKIN'] = 2683
}, {}

for name, id in pairs(TEMP) do
    _G[name] = id
    table.insert(FRUITS, id)
end

--    2. CONFIGURATION
SETUP = {
    MONEY = 1000, --REQUIRED MONEY(gp) TO PLAY SLOT MACHINE
    TIME = 200, --MILLISECONDS TO SWITCH FRUITS
    LIMIT = 20, --COUNTER TO STOP CHANGING FRUIT IF PLAYER DOESN'T (decreases each SETUP.TIME)
    LEVER = {1945, 1946},
    WIN = {
    -- [FRUITS] = {PRIZE,#PRIZE}]
        --MIXED COMBINATIONS
            [{CHERRY,PUMPKIN,CHERRY}] = {2160,2},
            [{LEMON,MELON,LEMON}] = {2160,1},
        --TRIPLE COMBINATIONS
            [{BERRY,BERRY,BERRY}] = {2152,80},
            [{MANGO,MANGO,MANGO}] = {2152,60},
            [{PUMPKIN,PUMPKIN,PUMPKIN}] = {2152,80},
            [{MELON,MELON,MELON}] = {2152,50},
            [{BANANA,BANANA,BANANA}] = {2152,40},
            [{LEMON,LEMON,LEMON}] = {2152,25},
            [{CHERRY,CHERRY,CHERRY}] = {2152,20},
            [{ORANGE,ORANGE,ORANGE}] = {2152,30},
            [{APPLE,APPLE,APPLE}] = {2152,10},
        --ANY COMBINATIONS
            [{ANY,PUMPKIN,PUMPKIN}] = {2152,5},
            [{PUMPKIN,PUMPKIN,ANY}] = {2152,5},
            [{PUMPKIN,ANY,PUMPKIN}] = {2152,10},
            [{ANY,CHERRY,CHERRY}] = {2152,4},
            [{CHERRY,CHERRY,ANY}] = {2152,4},
            [{CHERRY,ANY,CHERRY}] = {2152,8},
            [{ANY,LEMON,LEMON}] = {2152,5},
            [{LEMON,LEMON,ANY}] = {2152,5},
            [{LEMON,ANY,LEMON}] = {2152,5},
        },
    MSG = {'Bingo!','Lucky!','Jackpot!','Win!'},
    POS = {    --[LEVER.UNIQUEID] = {direction to row, distance from lever to row, position of lever}
        [6297] = {direction = WEST, distance = 2, pos = Position(1169, 986, 8)},
        [6298] = {direction = EAST, distance = 2, pos = Position(120, 325, 7)},
        [6299] = {direction = NORTH, distance = 2, pos = Position(116, 323, 7)},
        [6300] = {direction = WEST, distance = 2, pos = Position(114, 325, 7)},
    },
}

for lever, row in pairs(SETUP.POS) do
    local position = Position.getNextPosition(row.pos, row.direction, row.distance)
    for tile = 0, 2 do
        if row.direction % 2 == 0 then
            SETUP.POS[lever][tile+101] = Position(position.x+tile, position.y, position.z, 1)
        else
            SETUP.POS[lever][tile+101] = Position(position.x, position.y+tile, position.z, 1)
        end
    end
end

--    3. FUNCTIONS
function switchLever(lev)
    return doTransformItem(lev.uid, lev.itemid == SETUP.LEVER[1] and SETUP.LEVER[2] or SETUP.LEVER[1])
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

function verifyRow(cid, pos)
    local result = FALSE
    for combo, profit in pairs(SETUP.WIN) do
        if (getTileItemById(pos[101], combo[1]).uid > 0) or (combo[1] == ANY) then
            if (getTileItemById(pos[102], combo[2]).uid > 0) or (combo[2] == ANY) then
                if (getTileItemById(pos[103], combo[3]).uid > 0) or (combo[3] == ANY) then
                    result = TRUE
                    doPlayerAddItem(cid, profit[1], profit[2] or 1, TRUE)
                    doCreatureSay(cid, choose(SETUP.MSG), TALKTYPE_ORANGE_1)
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, 'Congratulations!! You won ' .. profit[2] .. ' ' .. getItemDescriptions(profit[1]).plural ..'!')
                    break
                end
            end
        end
    end
 
    for tile = 101, 103 do
        doRemoveItem(getTileThingByPos(pos[tile]).uid)
        doSendMagicEffect(pos[tile], result and CONST_ME_GIFT_WRAPS or CONST_ME_EXPLOSIONHIT)
    end 

    return not result and doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, 'You have lost in the Slot Machine :( Try again')
end

--    4. SCRIPT
function onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if getDirectionTo(getThingfromPos, fromPosition) > 3 then
        return TRUE
    end
   
    local function getLever()
        return getTileThingByPos(fromPosition)
    end
   
    if item.actionid == 0 then
        doSetItemActionId(item.uid, 100)
    end

    local function doFruit(pos, id, limit)
        if not isPlayer(cid) then
            doSetItemActionId(item.uid, 100)
            for tile = 100, 103 do
                if getTileThingByPos(pos[tile]).uid > 0 then
                    doRemoveItem(getTileThingByPos(pos[tile]).uid)
                end
            end
            return TRUE
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
            doSetItemActionId(getLever().uid, getLever().actionid+1)
            switchLever(getLever())
        elseif getLever().actionid > id then
            doSendMagicEffect(pos[id], math.random(28, 30))
            doTransformItem(getTileThingByPos(pos[id]).uid, choose(FRUITS))
        else
            addEvent(doFruit, SETUP.TIME, pos, id, limit-1)
        end
    end
 
    if item.actionid == 100 then
        if not doPlayerRemoveMoney(cid, SETUP.MONEY) then
            return doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, 'You need ' .. SETUP.MONEY ..' gps to play Slot Machine.')
        end
       
        doSetItemActionId(item.uid, 101)
        mayNotMove(cid, TRUE)
        switchLever(item)
        doCreatureSay(cid, '-$' .. SETUP.MONEY, TALKTYPE_ORANGE_1)
        for tile = 101, 103 do
            doFruit(SETUP.POS[item.uid], tile, (tile-100)*SETUP.LIMIT)
        end
    elseif isInArray({101,102,103}, item.actionid) then
        doSetItemActionId(item.uid, item.actionid+1)
        switchLever(item)
    elseif item.actionid == 104 then
        switchLever(item)
        mayNotMove(cid, FALSE)
        verifyRow(cid, SETUP.POS[item.uid])
        doSetItemActionId(item.uid, 100)
    end
    return TRUE
end