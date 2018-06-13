--[[
    Super Vocation Transformation Ring, originally written by artofwork aka Breed, Jotran, Codex NG :p
    Updated for a 1.2 server, however this will work as well for a 1.0 or 1.1 server.

    This script uses a gold ring (itemid 2179), however you can set it to use whatever item in movements.xml.

    What does this script do?
    When the item is equipped it will change the player's vocation to a new vocation and apply a series of conditions.

    Individual Health and Mana regen settings per vocation.
    Individual Health and Mana points settings per vocation.
    Individual Skills and Magic Level settings per vocation.
    A new outfit for the player including a mount they can ride.
    Super Haste for all vocations.
    Auto Manashield for sorcerer and druid.

    Please update your vocations.xml file in the data\XML directory with the new vocations.

    New in this script, outfits which contain mounts (amongst other things), settings to remove soul or an item.
    Items or Soul are removed per interval.

    Settings to disable constant special effect (can be an eyesore or just cpu intensive on older machines).

    Place this in movements.xml

    <!-- super vocation transformation ring -->
    <!-- gold ring -->
    <movevent event="Equip" itemid="2179" slot="ring" script="superVocationTransformationRing.lua" />
    <movevent event="DeEquip" itemid="2179" slot="ring" script="superVocationTransformationRing.lua" />

    Save this script as superVocationTransformationRing.lua
    In data\movements\scripts
]]

-- Configuration Start
local c = {
    useSoul = false, -- true to use soul, false to use an item instead
    soulAmount = 50, -- amount of soul to remove per interval, setting it to 0 will make the ring last forever
    itemid = 2160, -- item to use if useSoul is set to false
    itemAmount = 0, -- item amount to remove from the player, setting it to 0 will make the ring last forever
    vocationStorage = 18009, -- this holds the players old vocation
    effectsStorage = 18010, -- the special effects storage
    interval = 1, -- this effects the constant special effect but also the removal of the item/soul, 1 equals 1 second
    destroyItem = false, -- should the item be destroyed when it runs out of soul/item amount?
    disableAnimation = true -- the constant special effect that is applied to the player will be suppressed if set to true
}

local outfits = {
    [1] = { -- sorcerer new outfit after transformation --
        lookType = 130,
        lookHead = 19,
        lookBody = 71,
        lookLegs = 128,
        lookFeet = 128,
        lookMount = 368,
        lookAddons = 3
    },
    [2] = { -- druid new outfit after transformation --
        lookType = 63,
        lookHead = 20,
        lookBody = 30,
        lookLegs = 40,
        lookFeet = 50,
        lookMount = 624,
        lookAddons = 3
    },
    [3] = { -- paladin new outfit after transformation --
        lookType = 129,
        lookHead = 95,
        lookBody = 116,
        lookLegs = 121,
        lookFeet = 115,
        lookMount = 647,
        lookAddons = 3
    },
    [4] = { -- knight new outfit after transformation --
        lookType = 131,
        lookHead = 95,
        lookBody = 95,
        lookLegs = 95,
        lookFeet = 95,
        lookMount = 373,
        lookAddons = 3
    }
}

local effects = {
    [1] = { -- sorcer
        firsteffect = CONST_ME_ENERGYAREA,
        secondeffect = CONST_ME_BLOCKHIT,
        flingeffect = CONST_ANI_SMALLHOLY,
        landeffect = CONST_ME_TELEPORT,
        ringwaste = CONST_ME_FIREWORK_YELLOW,
        ringsorb = CONST_ME_FIREATTACK
    },
    [2] = { -- druid
        firsteffect = CONST_ME_ICEATTACK,
        secondeffect = CONST_ME_ICETORNADO,
        flingeffect = CONST_ME_ICETORNADO,
        landeffect = CONST_ME_ICETORNADO,
        ringwaste = CONST_ME_FIREWORK_BLUE,
        ringsorb = CONST_ME_MAGIC_BLUE
    },
    [3] = { -- paladin
        firsteffect = CONST_ME_YELLOW_RINGS,
        secondeffect = CONST_ME_BLOCKHIT,
        flingeffect = CONST_ANI_SMALLHOLY,
        landeffect = CONST_ME_HOLYAREA,
        ringwaste = CONST_ME_FIREWORK_YELLOW,
        ringsorb = CONST_ME_MAGIC_GREEN
    },
    [4] = { -- knight
        firsteffect = CONST_ME_EXPLOSIONAREA,
        secondeffect = CONST_ME_FIREAREA,
        flingeffect = CONST_ANI_FIRE,
        landeffect = CONST_ME_FIREWORK_RED,
        ringwaste = CONST_ME_FIREWORK_RED,
        ringsorb = CONST_ME_MAGIC_RED
    }

}

local stats = {
    [1] = { -- sorcerer
        parameters = {
            {CONDITION_PARAM_SKILL_SHIELD, 20},
            {CONDITION_PARAM_STAT_MAGICPOINTS, 35},
            {CONDITION_PARAM_STAT_MAXHITPOINTS, 100},
            {CONDITION_PARAM_STAT_MAXMANAPOINTS, 700}
        }
    },
    [2] = { -- druid
        parameters = {
            {CONDITION_PARAM_SKILL_SHIELD, 20},
            {CONDITION_PARAM_STAT_MAGICPOINTS, 35},
            {CONDITION_PARAM_STAT_MAXHITPOINTS, 100},
            {CONDITION_PARAM_STAT_MAXMANAPOINTS, 700}
        }
    },
    [3] = { -- paladin
        parameters = {
            {CONDITION_PARAM_SKILL_DISTANCE, 35},
            {CONDITION_PARAM_SKILL_SHIELD, 30},
            {CONDITION_PARAM_STAT_MAGICPOINTS, 15},
            {CONDITION_PARAM_STAT_MAXHITPOINTS, 400},
            {CONDITION_PARAM_STAT_MAXMANAPOINTS, 350}
        }
    },
    [4] = { -- knight
        parameters = {
            {CONDITION_PARAM_SKILL_FIST, 50},
            {CONDITION_PARAM_SKILL_CLUB, 50},
            {CONDITION_PARAM_SKILL_SWORD, 50},
            {CONDITION_PARAM_SKILL_AXE, 50},
            {CONDITION_PARAM_SKILL_SHIELD, 75},
            {CONDITION_PARAM_STAT_MAGICPOINTS, 10},
            {CONDITION_PARAM_STAT_MAXHITPOINTS, 1000},
            {CONDITION_PARAM_STAT_MAXMANAPOINTS, 250}
        }
    }
}

local regen = {
    [1] = { -- sorcerer
        health = 35,
        mana = 150
    },
    [2] = { -- druid
        health = 35,
        mana = 150
    },
    [3] = { -- paladin
        health = 100,
        mana = 100
    },
    [4] = { -- knight
        health = 150,
        mana = 50
    }
}
-- Configuration End

-- Do not edit anything below unless you know what you are doing.
local statsCondition = {}

for x = 1, #stats do
    statsCondition[x] = Condition(CONDITION_ATTRIBUTES, x)
    statsCondition[x]:setTicks(-1)
    for n = 1, #stats[x].parameters do
        statsCondition[x]:setParameter(stats[x].parameters[n][1], stats[x].parameters[n][2])
    end
end

local regenCondition = {}

for i = 1, #regen do
    regenCondition[i] = Condition(CONDITION_REGENERATION, i)
    regenCondition[i]:setTicks(-1)
    regenCondition[i]:setParameter(CONDITION_PARAM_HEALTHGAIN, regen[i].health)
    regenCondition[i]:setParameter(CONDITION_PARAM_MANAGAIN, regen[i].mana)
end

local haste = Condition(CONDITION_HASTE)
haste:setTicks(-1)
haste:setFormula( 2.5, 0, 3.0, 0)

local manashield = Condition(CONDITION_MANASHIELD)
manashield:setTicks(-1)

function distanceEffect(pos)
    return {
        [1] = {x = pos.x, y = pos.y - 3, z = pos.z, stackpos = 255}, -- north
        [2] = {x = pos.x, y = pos.y + 3, z = pos.z, stackpos = 255}, -- south
        [3] = {x = pos.x - 3, y = pos.y, z = pos.z, stackpos = 255}, -- west
        [4] = {x = pos.x + 3, y = pos.y, z = pos.z, stackpos = 255}, -- east

        [5] = {x = pos.x - 2, y = pos.y - 2, z = pos.z, stackpos = 255}, -- north west
        [6] = {x = pos.x + 2, y = pos.y - 2, z = pos.z, stackpos = 255}, -- north east
        [7] = {x = pos.x + 2, y = pos.y + 2, z = pos.z, stackpos = 255}, -- south east
        [8] = {x = pos.x - 2, y = pos.y + 2, z = pos.z, stackpos = 255}  -- south west
    }
end

function isValidVocation(id)
    local possibleVocations = { -- corresponding vocations
        [{1, 5}] = 11, -- sorcerer / master sorcerer to super master sorcerer
        [{2, 6}] = 12, -- druid / elder druid to super elder druid
        [{3, 7}] = 13, -- paladin / royal paladin to super royal paladin
        [{4, 8}] = 14, -- knight / elite knight to super elite knight
        [{9, 10}] = 15 -- templar / noble templar to warlord templar
    }
    for oldVocation, newVocation in pairs(possibleVocations) do
        if isInArray(oldVocation, id) then
            return newVocation
        end
    end
    return id
end

function reset(p)
    local player = Player(p.cid)
    if player then
        player:removeCondition(CONDITION_ATTRIBUTES, p.id)
        player:removeCondition(CONDITION_REGENERATION, p.id)
        player:removeCondition(CONDITION_HASTE)
        player:removeCondition(CONDITION_OUTFIT)
        if isInArray({1, 2}, p.id) then
            player:removeCondition(CONDITION_MANASHIELD)
        end
        if c.destroyItem then
            local item = player:getSlotItem(p.slot)
            if item then
                item:remove()
            end
        end
        player:setStorageValue(c.vocationStorage, -1)
        player:setVocation(p.id)
    end
end
--[[
function animate(cid, position, id)
    local player = Player(cid)
    if player then
        if player:getStorageValue(c.effectsStorage) == 1 then
            Position(position):sendMagicEffect(effects[id].firsteffect)
            Position(position):sendMagicEffect(effects[id].secondeffect)
            local direction = distanceEffect(position)
            for m = 1, #direction do
                Position(position):sendDistanceEffect(direction[m], effects[id].flingeffect)
            end
            for o = 1, #direction do
                Position(direction[o]):sendMagicEffect(effects[id].landeffect)
            end
        end
    end
end
]]
function transform(p)
    local player = Player(p.cid)
    if player then
        --animate(p.cid, player:getPosition(), p.id)
        --doSetCreatureOutfit(player, outfits[p.id], -1)
        player:addCondition(statsCondition[p.id])
        if isInArray({1, 2}, p.id) then
            player:addCondition(manashield)
        end
        player:addCondition(haste)
        player:addCondition(regenCondition[p.id])
        player:setVocation(isValidVocation( p.id ))
        if not c.disableAnimation then
            addEvent(specialEffect, 1, p)
        else
            addEvent(skipToVerification, 1, p)
        end
    end
end

function skipToVerification(p)
    if verify(p.cid) then
        addEvent(skipToVerification, c.interval * 1000, p)
    else
        reset(p)
    end
end

function verify(cid)
    local player = Player(cid)
    if player then
        if c.useSoul then
            if player:getSoul() < c.soulAmount then
                return false
            end
            player:addSoul(-c.soulAmount)
        else
            if player:getItemCount(c.itemid) < c.itemAmount then
                return false
            end
            player:removeItem(c.itemid, c.itemAmount)
        end
    end
    return true
end

function specialEffect(p)
    local player = Player(p.cid)
    if player then
        if verify(p.cid) then
            if player:getStorageValue(c.effectsStorage) == 1 then
                local position = player:getPosition()
                position:sendMagicEffect(effects[p.id].ringwaste)
                position:sendMagicEffect(effects[p.id].ringsorb)
                --animate(position, p.id)
                addEvent(specialEffect, c.interval * 1000, p)
            end
        else
            reset(p)
        end
    end
end

function getMsg()
    local name = c.useSoul and 'soul point' or ItemType(c.itemid):getName()
    local amount = c.useSoul and c.soulAmount or c.itemAmount
    return " you don't have enough " .. name .. "s, you need atleast " .. amount .. " to benefit from the effects of this ring."
end

function onEquip(cid, item, slot)
    -- this will make it compatible for 1.0, 1.1, 1.2
    local player = type(cid) == 'number' and Player(cid) or cid
    local slots = player:getSlotItem(slot)
    if slots then
        if slots.itemid ~= item.itemid then
            return true
        else
            if not verify(player:getId()) then
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Sorry, ' .. player:getName() .. getMsg())
                return false
            end
            if player:getStorageValue(c.vocationStorage) < 1 then
                local vocationId = player:getVocation():getId()
                player:setStorageValue(c.vocationStorage, vocationId)
                player:setStorageValue(c.effectsStorage, 1)
            end
            player:say("Equip", TALKTYPE_ORANGE_1)
            local p = { cid = player:getId(), item = item, slot = slot, id = player:getStorageValue(c.vocationStorage) }
            addEvent(transform, 1, p)
        end
    end
    return true
end

function onDeEquip(cid, item, slot)
    -- this will make it compatible for 1.0, 1.1, 1.2
    local player = type(cid) == 'number' and Player(cid) or cid
    local vocationId = player:getStorageValue(c.vocationStorage)
    if vocationId > 0 then
        player:say("deEquip", TALKTYPE_ORANGE_1)
        --animate(player:getId(), player:getPosition(), vocationId)
        local p = {cid = player:getId(), id = vocationId, slot = slot}
        player:setStorageValue(c.effectsStorage, -1)
        reset(p)
    end
    return true
end