local config = {
   ["stormblast"] = {time = 120, wallPos = {x = 322, y = 50, z = 6}}
}
local function deleteWall(tp)
   local brokenWall = getTileItemById(tp, 19604).uid
   if(brokenWall > 0) then
     doRemoveItem(brokenWall)
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

local function addWall(tp)
   local brokenWall = getTileItemById(tp, 19604).uid
   if(brokenWall == 0) then
     Game.createItem(19604, 1, Position(322, 50, 6))
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

function onKill(cid, target)
   local monster = config[getCreatureName(target):lower()]

   if(isPlayer(target) or not monster) then
     return true
   end
   addEvent(deleteWall, 1000, monster.wallPos)
   addEvent(addWall, monster.time * 1000, monster.wallPos)
   
   return true
end