local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 45)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
 
local baseMana = 500
 
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
        if targetPlayer:getPosition():getDistance(position) <= 8 then
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
     pos:sendDistanceEffect(position, 12)
            position:sendMagicEffect(45)
       
 
local time = 5 * 60 * 1000
local time2 = 5
    local slvl = creature:getEffectiveSkillLevel(SKILL_SHIELD) / 10
doPlayerSendTextMessage(targetPlayer, MESSAGE_INFO_DESCR, "Defense + [" .. slvl .. "/s] for [" .. time2 .."] min!")
 
 
local skill = Condition(CONDITION_ATTRIBUTES)
skill:setParameter(CONDITION_PARAM_SUBID, 550)
skill:setParameter(CONDITION_PARAM_TICKS, time)
skill:setParameter(CONDITION_PARAM_SKILL_SHIELD, slvl)
skill:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:setCondition(skill)
 
 
        targetPlayer:addCondition(skill)
 
    end
    return true
end