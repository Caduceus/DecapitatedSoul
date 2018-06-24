--// Do not touch
local conditionSlots = {
    [CONST_SLOT_HEAD]     = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_HEAD),     id = CONDITIONID_HEAD},
    [CONST_SLOT_NECKLACE] = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_NECKLACE), id = CONDITIONID_NECKLACE},
    [CONST_SLOT_BACKPACK] = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_BACKPACK), id = CONDITIONID_BACKPACK},
    [CONST_SLOT_ARMOR]    = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_ARMOR),    id = CONDITIONID_ARMOR},
    [CONST_SLOT_RIGHT]    = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_RIGHT),    id = CONDITIONID_RIGHT},
    [CONST_SLOT_LEFT]     = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_LEFT),     id = CONDITIONID_LEFT},
    [CONST_SLOT_LEGS]     = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_LEGS),     id = CONDITIONID_LEGS},
    [CONST_SLOT_FEET]     = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_FEET),     id = CONDITIONID_FEET},
    [CONST_SLOT_RING]     = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_RING),     id = CONDITIONID_RING},
    [CONST_SLOT_AMMO]     = {condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_AMMO),     id = CONDITIONID_AMMO}
}
 
-- Set all conditions to infinite ticks
for i = 1, #conditionSlots do
    conditionSlots[i].condition:setParameter(CONDITION_PARAM_TICKS, -1)
end
 
local params = {
    CONDITION_PARAM_SKILL_MELEE,
    CONDITION_PARAM_SKILL_FIST,
    CONDITION_PARAM_SKILL_CLUB,
    CONDITION_PARAM_SKILL_SWORD,
    CONDITION_PARAM_SKILL_AXE,
    CONDITION_PARAM_SKILL_DISTANCE,
    CONDITION_PARAM_SKILL_SHIELD,
    CONDITION_PARAM_SKILL_FISHING,
    CONDITION_PARAM_STAT_MAXHITPOINTS,
    CONDITION_PARAM_STAT_MAXMANAPOINTS,
    --CONDITION_PARAM_STAT_SOULPOINTS,
    CONDITION_PARAM_STAT_MAGICPOINTS,
    CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT,
    CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT,
    --CONDITION_PARAM_STAT_SOULPOINTSPERCENT,
    CONDITION_PARAM_STAT_MAGICPOINTSPERCENT,
    CONDITION_PARAM_SKILL_MELEEPERCENT,
    CONDITION_PARAM_SKILL_FISTPERCENT,
    CONDITION_PARAM_SKILL_CLUBPERCENT,
    CONDITION_PARAM_SKILL_SWORDPERCENT,
    CONDITION_PARAM_SKILL_AXEPERCENT,
    CONDITION_PARAM_SKILL_DISTANCEPERCENT,
    CONDITION_PARAM_SKILL_SHIELDPERCENT,
    CONDITION_PARAM_SKILL_FISHINGPERCENT,
    CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE,
	CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE,
	CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE,
	CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT,
	CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE,
	CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT,
	CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCEPERCENT,
	CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGEPERCENT,
	CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCEPERCENT,
	CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNTPERCENT,
	CONDITION_PARAM_SKILL_MANA_LEECH_CHANCEPERCENT,
	CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNTPERCENT
}
--\\
 
-- Item config
itemBonusConfig = {
    -- string = -int
    -- strings = +int
    [16105] = {
        [1] = {
            {param = CONDITION_PARAM_STAT_MAGICPOINTS, value = 10, strings = {"Magic Level"}},
        },
        [2] = {
            {param = CONDITION_PARAM_STAT_MAGICPOINTS, value = 10, strings = {"Magic Level"}},
        },
        [3] = {
            {param = CONDITION_PARAM_SKILL_DISTANCE, value = 10, strings = {"Distance"}},
        },
        [4] = {
            {param = CONDITION_PARAM_SKILL_MELEE, value = 10, strings = {"Sword", "Axe", "Club"}},
        },
        [9] = {
            {param = CONDITION_PARAM_SKILL_MELEE, value = 5, strings = {"Sword", "Axe", "Club"}},
            {param = CONDITION_PARAM_STAT_MAGICPOINTS, value = 5, strings = {"Magic Level"}},
        },
    },
    [16106] = {
        [1] = {
            {param = CONDITION_PARAM_STAT_MAGICPOINTS, value = 15, strings = {"Magic Level"}},
        },
        [2] = {
            {param = CONDITION_PARAM_STAT_MAGICPOINTS, value = 15, strings = {"Magic Level"}},
        },
        [3] = {
            {param = CONDITION_PARAM_SKILL_DISTANCE, value = 15, strings = {"Distance"}},
        },
        [4] = {
            {param = CONDITION_PARAM_SKILL_MELEE, value = 15, strings = {"Sword", "Axe", "Club"}},
        },
        [9] = {
            {param = CONDITION_PARAM_SKILL_MELEE, value = 10, strings = {"Sword", "Axe", "Club"}},
            {param = CONDITION_PARAM_STAT_MAGICPOINTS, value = 10, strings = {"Magic Level"}},
        },
    }
}
 
function onEquip(player, item, slot)
    local statItem = itemBonusConfig[item.itemid]
    local vocStats = statItem and statItem[player:getVocation():getBase():getId()]
 
    if not vocStats then
        return true
    end
    
    if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING,"You cannot equip this item while in battle!")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
 
    local condition = conditionSlots[slot].condition
 
    -- Remove previous parameters so all params don't get added
    for p = 1, #params do
        condition:setParameter(params[p], 0)
    end
 
    -- Set new parameters
    for i = 1, #vocStats do
        condition:setParameter(vocStats[i].param, vocStats[i].value)
    end
 
    player:addCondition(condition)
    player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
    player:getPosition():sendMagicEffect(CONST_ME_HITBYPOISON)
 
    return true
end
 
function onDeEquip(player, item, slot)
    local conditionId = conditionSlots[slot].id
    if player:getCondition(CONDITION_ATTRIBUTES, conditionId) then
        player:removeCondition(CONDITION_ATTRIBUTES, conditionId)
    end
    return true
end