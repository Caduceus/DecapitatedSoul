local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 50)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
 
local baseMana = 200
 
function onCastSpell(creature, variant, isHotkey)
    local position = creature:getPosition()
    local party = creature:getParty()
    if not party then
        creature:sendCancelMessage("No party members in range.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end
 
    local membersList = party:getMembers()
    membersList[#membersList + 1] = party:getLeader()
 
    if membersList == nil or type(membersList) ~= 'table' or #membersList <= 1 then
        creature:sendCancelMessage("No party members in range.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end
 
    local affectedList = {}
    for _, targetPlayer in ipairs(membersList) do
        if targetPlayer:getPosition():getDistance(position) <= 4 then
            affectedList[#affectedList + 1] = targetPlayer
        end
    end
 
    local count = #affectedList
    if count <= 1 then
        creature:sendCancelMessage("No party members in range.")
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end
 
    local mana = math.ceil((0.9 ^ (count - 1) * baseMana) * count)
    if creature:getMana() < mana then
        creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    elseif not combat:execute(creature, variant) then
        creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end
    creature:addMana(baseMana - mana, false)
    creature:addManaSpent(mana - baseMana)
 
    for _, targetPlayer in ipairs(affectedList) do
   
    local position = targetPlayer:getPosition()
        local pos = creature:getPosition()
     pos:sendDistanceEffect(position, 31)
            position:sendMagicEffect(50)
           
   
    local lvl = creature:getLevel()
    local mlvl = creature:getMagicLevel()
 
    local min = (lvl * 6) + (mlvl * 6) + 10  
    local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_SUBID, 520)
condition:setParameter(CONDITION_PARAM_TICKS, 100)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, min)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 100)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
 
        targetPlayer:addCondition(condition)
 
    end
    return true
end