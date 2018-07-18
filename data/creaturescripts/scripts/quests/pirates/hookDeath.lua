local config = {
   ["captain hook"] = {time = 120, wallPos = {x = 78, y = 191, z = 7}}
}

local function openGate(tp)
   local gateClosed = getTileItemById(tp, 5735).uid
   if(gateClosed > 0) then
     doRemoveItem(gateClosed)
     Game.createItem(5737, 1, Position(78, 191, 7))
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

local function closeGate(tp)
   local playerClosed = getTileItemById(tp, 5736).uid
   local gateOpen = getTileItemById(tp, 5737).uid
   if(gateOpen > 0) or (playerClosed > 0) then
     doRemoveItem(gateOpen)
     doRemoveItem(playerClosed)
     Game.createItem(5735, 1, Position(78, 191, 7))
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

function onKill(cid, target)
   local monster = config[getCreatureName(target):lower()]

   if(isPlayer(target) or not monster) then
     return true
   end
   addEvent(openGate, 1000, monster.wallPos)
   addEvent(closeGate, monster.time * 1000, monster.wallPos)
   
   return true
end