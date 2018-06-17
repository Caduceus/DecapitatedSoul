tp_pads = {
   [8300] = {price = 0, name = "Caduceus Manor", storage = 99586},
   [8301] = {price = 0, name = "Targovista", storage = 99587},
   [8302] = {price = 0, name = "Poenari", storage = 99598},
   [8303] = {price = 250, name = "Temple", storage = 99588},
   [8304] = {price = 10000, name = "Demon Section", storage = 99589},
   [8305] = {price = 10000, name = "Juggernaught Section", storage = 99590},
   [8306] = {price = 50000, name = "Grim Reaper Section", storage = 99591},
   [8307] = {price = 50000, name = "Ghastly Dragon Section", storage = 99592},
   [8308] = {price = 50000, name = "Frost Dragon Section", storage = 99593},
   [8309] = {price = 100000, name = "Frozen Hell Inn", storage = 99594},
   [8310] = {price = 50000, name = "Apocalypse Portal", storage = 99595},
   [8311] = {price = 50000, name = "Trigama Section", storage = 99596},
   [8312] = {price = 10000, name = "Demodras Section", storage = 99597},
   [8313] = {price = 10000, name = "Warlock Section", storage = 99599},
   

}

function onSay(cid, word, param)
local player = Player(cid)
    if not player then
        return true
    end
if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING,"You cannot use a portal while in battle!")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

   if not player:isVip() then 
   player:sendTextMessage(MESSAGE_STATUS_WARNING,"You do not have a VIP account.")
   return false
   end
   
   if player:isPzLocked() then
     player:teleportTo(fromPosition)
     player:say("The pad is not responding.", TALKTYPE_ORANGE_1, true, player, player:getPosition())
   else   
     local padWindow = ModalWindow(1860, "portal system", "Key:\n[*] = new\n[~] = moving\n\nSelect destination:")
     for i = 8300, 8313 do
         if tp_pads[i].price then
           if tp_pads[i].storage then
             if player:getStorageValue(tp_pads[i].storage) > 0 then
               padWindow:addChoice(i - 8300, tp_pads[i].name .. (tp_pads[i].price > 0 and " [" .. tp_pads[i].price .. " gold]" or ""))
             end
           else
             padWindow:addChoice(i - 8300, tp_pads[i].name .. (tp_pads[i].price > 0 and " [" .. tp_pads[i].price .. " gold]" or ""))
           end
         else
           if tp_pads[i].storage then
             if player:getStorageValue(tp_pads[i].storage) > 0 then
               padWindow:addChoice(i - 8300, tp_pads[i].name)
             end
           else
             padWindow:addChoice(i - 8300, tp_pads[i].name)
           end
         end
       end
     padWindow:addButton(1, "Select")
     padWindow:addButton(2, "Cancel")
     padWindow:setDefaultEnterButton(1)
     padWindow:setDefaultEscapeButton(2)
     padWindow:sendToPlayer(player)
   end
   return false
end
