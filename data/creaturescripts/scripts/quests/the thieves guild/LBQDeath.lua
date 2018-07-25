local config = {
   ["lost barbarian queen"] = {time = 120, fireTime = 125, wallPos = {x = 298, y = 266, z = 14}, wallPos2 = {x = 297, y = 267, z = 14}}
}

local function openGate(tp)
   local gateClosed = getTileItemById(tp, 5478).uid
   if(gateClosed > 0) then
     doRemoveItem(gateClosed)
     Game.createItem(5479, 1, Position(297, 267, 14))
     doCreatureSay(cid,"Bish!",TALKTYPE_ORANGE_1)
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

local function closeGate(tp)
   local gateOpen = getTileItemById(tp, 5479).uid
   if(gateOpen > 0) then
     doRemoveItem(gateOpen)
     Game.createItem(5478, 1, Position(298, 266, 14))
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

local function addFire(tp)
     Game.createItem(1423, 1, Position(295, 269, 13))
     Game.createItem(1423, 1, Position(301, 269, 13))
     Game.createItem(1423, 1, Position(295, 275, 13))
     Game.createItem(1423, 1, Position(301, 275, 13))
   return true
end

local function removeFire(tp)
   local fireRemoved = getTileItemById(tp, 1423).uid
   if(fireRemoved > 0) then
     doRemoveItem(fireRemoved)
     Game.createItem(1425, 1, Position(295, 269, 13))
     Game.createItem(1425, 1, Position(301, 269, 13))
     Game.createItem(1425, 1, Position(295, 275, 13))
     Game.createItem(1425, 1, Position(301, 275, 13))
   end
   return true
end

function onKill(cid, target)
   local monster = config[getCreatureName(target):lower()]

   if(isPlayer(target) or not monster) then
     return true
   end
   addEvent(addFire, 1000, monster.wallPos)
   addEvent(openGate, 4 * 1000, monster.wallPos)
   addEvent(closeGate, monster.time * 1000, monster.wallPos2)
   addEvent(removeFire, monster.fireTime * 1000, Position(295, 269, 13))
   addEvent(removeFire, monster.fireTime * 1000, Position(301, 269, 13))
   addEvent(removeFire, monster.fireTime * 1000, Position(295, 275, 13))
   addEvent(removeFire, monster.fireTime * 1000, Position(301, 275, 13))

   
   return true
end
