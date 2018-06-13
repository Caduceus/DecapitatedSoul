local groundIds = {
    294, 369, 370, 383, 392, 408, 409, 410, 427, 428, 430, 462, 469, 470, 482,
    484, 485, 489, 924, 3135, 3136, 7933, 7938, 8170, 8286, 8285, 8284, 8281,
    8280, 8279, 8277, 8276, 8567, 8585, 8596, 8595, 8249, 8250, 8251,
    8252, 8253, 8254, 8255, 8256, 8592, 8972, 9606, 9625, 13190, 14461, 19519, 21536
}

local storages = {82001, 82002, 82003}

local function doRemoveTeleport(pos)
    local tp = Tile(pos):getItemById(1387)
    if tp then
        tp:remove()
    end
    return true
end

function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey, player)
    local s, player = {}, Player(cid)
    for x = 1, 3 do
        s[#s + 1] = player:getStorageValue(storages[x])
    end

    if player:getExhaustion(1000) > 0 then
        player:say('Your Starlight is still recharging!', TALKTYPE_MONSTER_SAY)
        return true
    end

    if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:say('You cannot make a Portal whilst in battle!', TALKTYPE_MONSTER_SAY)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    player:setExhaustion(1000, 10)

    if s[1] < 0 then
        player:say('You need to set your position!', TALKTYPE_MONSTER_SAY)
        return true
    end

    if toPosition.x == s[1] and toPosition.y == s[2] and toPosition.z == s[3] then
        player:say('You cannot create a portal here.', TALKTYPE_MONSTER_SAY)
        return true
    end

    local tile = Tile(toPosition)
    local ground = tile:getGround()
    if ground and isInArray(groundIds, ground:getId())
            or tile:getItemById(14435)
            or tile:getItemById(1387)
            or tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID)
            or tile:hasProperty(CONST_PROP_NOFIELDBLOCKPATH) then
        player:say('You cannot make a Portal here..', TALKTYPE_MONSTER_SAY)
        return true
    end

local teleport = Game.createItem(1387, 1, toPosition)
if teleport then
teleport:setActionId(2361)
teleport:setAttribute('description', 'Only ' .. player:getName():lower() .. ' can use this teleport.')
end

    addEvent(doRemoveTeleport, 10 * 1000, toPosition)
    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
    player:say('Your Frozen Starlight shimmers and creates a portal', TALKTYPE_MONSTER_SAY)
    return true
end
