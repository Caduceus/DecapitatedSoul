local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_DRAWBLOOD)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, 1)

local Crossbows = {2455, 5803, 8849, 8850, 8851, 8852, 8853, 18453, 15644, 16111, 22419, 22420, 22421}
local Bows = {2456, 7438, 8854, 8855, 8856, 8857, 8858, 10295, 13873, 15643, 15644, 18454, 22416, 22417, 22418}
local Arrows = {2544, 2545, 2546, 7365, 7364, 7838, 7840, 7839, 7850, 15648, 18437, 18304}
local Bolts = {2543, 2547, 6529, 7363, 15649, 18435, 18436}
local Throwables = {2111, 2389, 3965, 7367, 7378, 2399, 7368, 7366, 2410}

local animation = {
[2543] = CONST_ANI_BOLT,
[2547] = CONST_ANI_POWERBOLT,
[6529] = CONST_ANI_INFERNALBOLT,
[7363] = CONST_ANI_PIERCINGBOLT,
[15649] = CONST_ANI_VORTEXBOLT,
[18435] = CONST_ANI_PRISMATICBOLT,
[18436] = CONST_ANI_DRILLBOLT,

[2544] = CONST_ANI_ARROW,
[2545] = CONST_ANI_POISONARROW,
[2546] = CONST_ANI_BURSTARROW,
[7365] = CONST_ANI_ONYXARROW,
[7364] = CONST_ANI_SNIPERARROW,
[7838] = CONST_ANI_FLASHARROW,
[7840] = CONST_ANI_FLAMMINGARROW,
[7839] = CONST_ANI_SHIVERARROW,
[7850] = CONST_ANI_EARTHARROW,
[15648] = CONST_ANI_TARSALARROW,
[18437] = CONST_ANI_ENVENOMEDARROW,
[18304] = CONST_ANI_CRYSTALLINEARROW,

[2111] = CONST_ANI_SNOWBALL,
[2389] = CONST_ANI_SPEAR,
[3965] = CONST_ANI_HUNTINGSPEAR,
[7367] = CONST_ANI_ENCHANTEDSPEAR,
[7378] = CONST_ANI_ROYALSPEAR,
[2399] = CONST_ANI_THROWINGSTAR,
[7368] = CONST_ANI_REDSTAR,
[7366] = CONST_ANI_GREENSTAR,
[2410] = CONST_ANI_THROWINGKNIFE
}

local damageType = {
[2544] = COMBAT_PHYSICALDAMAGE,
[2545] = COMBAT_PHYSICALDAMAGE,
[2546] = COMBAT_FIREDAMAGE,
[7365] = COMBAT_PHYSICALDAMAGE,
[7364] = COMBAT_PHYSICALDAMAGE,
[7838] = COMBAT_ENERGYDAMAGE,
[7840] = COMBAT_FIREDAMAGE,
[7839] = COMBAT_ICEDAMAGE,
[7850] = COMBAT_EARTHDAMAGE,
[15648] = COMBAT_EARTHDAMAGE,
[18437] = COMBAT_EARTHDAMAGE,
[18304] = COMBAT_EARTHDAMAGE,
[2111] = COMBAT_PHYSICALDAMAGE,
[2389] = COMBAT_PHYSICALDAMAGE,
[3965] = COMBAT_PHYSICALDAMAGE,
[7367] = COMBAT_PHYSICALDAMAGE,
[7378] = COMBAT_PHYSICALDAMAGE,
[2399] = COMBAT_PHYSICALDAMAGE,
[7368] = COMBAT_PHYSICALDAMAGE,
[7366] = COMBAT_PHYSICALDAMAGE,
[2410] = COMBAT_PHYSICALDAMAGE,
[2543] = COMBAT_PHYSICALDAMAGE,
[2547] = COMBAT_PHYSICALDAMAGE,
[6529] = COMBAT_PHYSICALDAMAGE,
[7363] = COMBAT_PHYSICALDAMAGE,
[15649] = COMBAT_PHYSICALDAMAGE,
[18435] = COMBAT_PHYSICALDAMAGE,
[18436] = COMBAT_PHYSICALDAMAGE,
[2111] = COMBAT_PHYSICALDAMAGE,
[2389] = COMBAT_PHYSICALDAMAGE,
[3965] = COMBAT_PHYSICALDAMAGE,
[7367] = COMBAT_PHYSICALDAMAGE,
[7378] = COMBAT_PHYSICALDAMAGE,
[2399] = COMBAT_PHYSICALDAMAGE,
[7368] = COMBAT_PHYSICALDAMAGE,
[7366] = COMBAT_PHYSICALDAMAGE,
[2410] = COMBAT_PHYSICALDAMAGE,
[1294] = COMBAT_PHYSICALDAMAGE
}
local magicEffect = 0
local dmgType = 0

local function doDoubleShotCombat(player, var)
    function getDistanceDamage(player, skill, attackValue, attackFactor)
        local level = player:getLevel()
            min = -(attackValue)
            max = -(attackValue + (level/5) + (skill/2) * 2.5)
        return min, max
    end
    local item = player:getSlotItem(CONST_SLOT_AMMO)
    combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "getDistanceDamage")
    combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, magicEffect)
    combat:setParameter(COMBAT_PARAM_TYPE, dmgType)
    combat:execute(player, var)
    --item:remove(1)
    return true
end

local function doDoubleShot(player, var)
local leftHand = pushThing(player:getSlotItem(CONST_SLOT_LEFT)).itemid
local rightHand = pushThing(player:getSlotItem(CONST_SLOT_RIGHT)).itemid
local ammoSlot = pushThing(player:getSlotItem(CONST_SLOT_AMMO)).itemid
    dmgType = damageType[ammoSlot]
    if(isInArray(Crossbows, leftHand) or isInArray(Crossbows, rightHand)) then
        if(isInArray(Bolts, ammoSlot)) then
            magicEffect = animation[ammoSlot]
            return doDoubleShotCombat(player, var)
        else
            return player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You need bolts")
        end
    elseif(isInArray(Bows, leftHand) or isInArray(Bows, rightHand)) then
        if(isInArray(Arrows, ammoSlot)) then
            magicEffect = animation[ammoSlot]
            return doDoubleShotCombat(player, var)
        else
            return player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You need arrows")
        end
    elseif(isInArray(Throwables, leftHand) or isInArray(Throwables, rightHand)) then
        if(isInArray(Throwables, leftHand)) then
            magicEffect = animation[leftHand]
        else
            magicEffect = animation[rightHand]
        end
        return doDoubleShotCombat(player, var)
    end
    return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need a distance weapon")
end

function onCastSpell(player, var)
    return doDoubleShot(player, var)
end