function onModalWindow(player, modalWindowId, buttonId, choiceId)
   if modalWindowId == 1860 then
     if not tp_pads[choiceId + 8300] then
       return true
     end
   
     local npos = Item(choiceId + 8300):getPosition()
     if buttonId == 1 then
       if tp_pads[choiceId + 8300].price ~= nil then
         if not player:removeMoneyNpc(tp_pads[choiceId + 8300].price) then
           doPlayerSendTextMessage(player, MESSAGE_INFO_DESCR, "You don't have enough money.")
           return true
         end
       end
       
       player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
       player:teleportTo(npos)
       player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
       return true
     end
   end
   return true
end

function onLogin(player)
   player:registerEvent("tp_pad")
   return true
end