function onSay(cid, word, param)
local player = Player(cid)
    if not player then
        return true
    end
    
if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING,"You cannot use command whilst in battle!")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

if not player:isVip() then 
   player:sendTextMessage(MESSAGE_STATUS_WARNING,"You do not have a VIP account.")
   return true 
   end
   
if player:removeMoneyNpc(25000) == true then
    player:addItem(2173) 
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have bought an amulet of loss.")
else 
    player:sendTextMessage(MESSAGE_STATUS_WARNING,"You do not have enough money.")
    return false
   end 
end 
           