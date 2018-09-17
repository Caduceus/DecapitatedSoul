local sets = {
--descripcion, helmet, body, legs, boots
    [1] = {'Lava Set', 7900, 7899, 7894, 7891},
    [2] = {'Ice Set', 7902, 7897, 7896, 7892},
    [3] = {'Energy Set', 7901, 7898, 7895, 7893},
    [4] = {'Tera Set', 7903, 7884, 7885, 7886},
    [5] = {'Hood', 10562, 0, 0, 0}

}
 
local speed1 = Condition(CONDITION_HASTE)
speed1:setTicks(-1)
speed1:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
speed1:setParameter(CONDITION_PARAM_SUBID, 10)
speed1:setParameter(CONDITION_PARAM_SPEED, 10)
 
local speed2 = Condition(CONDITION_HASTE)
speed2:setTicks(-1)
speed2:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
speed2:setParameter(CONDITION_PARAM_SUBID, 11)
speed2:setParameter(CONDITION_PARAM_SPEED, 20)
 
local shield1 = Condition(CONDITION_ATTRIBUTES)
shield1:setTicks(-1)
shield1:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
shield1:setParameter(CONDITION_PARAM_SUBID, 12)
shield1:setParameter(CONDITION_PARAM_SKILL_SHIELD, 2)
 
local shield2 = Condition(CONDITION_ATTRIBUTES)
shield2:setTicks(-1)
shield2:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
shield2:setParameter(CONDITION_PARAM_SUBID, 13)
shield2:setParameter(CONDITION_PARAM_SKILL_SHIELD, 5)
 
--getPlayerSlotItem(cid, 1) --helmet
--getPlayerSlotItem(cid, 4) --armor
--getPlayerSlotItem(cid, 7) --legs
--getPlayerSlotItem(cid, 8) --boots
 
local setBonus = { --- [] = {condition = , maxHealth = , maxMana = }
    [1] = {condition = speed1, typ = CONDITION_HASTE, sub = 10}, --Lava Set
    [2] = {condition = shield1, typ = CONDITION_ATTRIBUTES, sub = 12}, --Ice Set
    [3] = {condition = speed2, typ = CONDITION_HASTE, sub = 11}, --Energy Set
    [4] = {condition = shield2, typ = CONDITION_ATTRIBUTES, sub = 13}, --Terra Set
    [5] = {condition = shield1, typ = CONDITION_ATTRIBUTES, sub = 12} --hood
}
 
local storage = 17181
 
function onDeEquip(cid, item, slot)
    local player = Player(cid)
    for i = 1, #sets do
        if player:getStorageValue(storage) > 0 then
            if (slot == 1 and pushThing(player:getSlotItem(CONST_SLOT_ARMOR)).itemid == sets[i][3] and pushThing(player:getSlotItem(CONST_SLOT_LEGS)).itemid == sets[i][4] and pushThing(player:getSlotItem(CONST_SLOT_FEET)).itemid == sets[i][5]) 
            or (slot == 4 and pushThing(player:getSlotItem(CONST_SLOT_HEAD)).itemid == sets[i][2] and pushThing(player:getSlotItem(CONST_SLOT_LEGS)).itemid == sets[i][4] and pushThing(player:getSlotItem(CONST_SLOT_FEET)).itemid == sets[i][5]) 
            or (slot == 7 and pushThing(player:getSlotItem(CONST_SLOT_HEAD)).itemid == sets[i][2] and pushThing(player:getSlotItem(CONST_SLOT_ARMOR)).itemid == sets[i][3] and pushThing(player:getSlotItem(CONST_SLOT_FEET)).itemid == sets[i][5]) 
            or (slot == 8 and pushThing(player:getSlotItem(CONST_SLOT_HEAD)).itemid == sets[i][2] and pushThing(player:getSlotItem(CONST_SLOT_ARMOR)).itemid == sets[i][3] and pushThing(player:getSlotItem(CONST_SLOT_LEGS)).itemid == sets[i][4]) then
                player:sendTextMessage(MESSAGE_INFO_DESCR, sets[i][1].." disabled.")
              
            if (setBonus[i]).condition ~= nil then
                player:removeCondition((setBonus[i]).typ, CONDITIONID_COMBAT, (setBonus[i]).sub)
            end
 
            player:setStorageValue(storage, 0)
            end
        end
    end
    return true
end
 
function onEquip(cid, item, slot)
    local player = Player(cid)
    for i = 1, #sets do
        if player:getStorageValue(storage) < 1 then
            if pushThing(player:getSlotItem(CONST_SLOT_HEAD)).itemid == sets[i][2] and pushThing(player:getSlotItem(CONST_SLOT_ARMOR)).itemid == sets[i][3] and pushThing(player:getSlotItem(CONST_SLOT_LEGS)).itemid == sets[i][4] and pushThing(player:getSlotItem(CONST_SLOT_FEET)).itemid == sets[i][5] then
                player:sendTextMessage(MESSAGE_INFO_DESCR, sets[i][1].." enabled.")
           
            if (setBonus[i]).condition ~= nil then
                player:addCondition((setBonus[i]).condition)
            end
       
            player:setStorageValue(storage, 1)
            end
        end
    end
    return true
end
