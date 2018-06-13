local config = {
   ["medusa"] = {time = 120, wallPos = {x = 192, y = 61, z = 6}}
}
local function deleteWall(tp)
   local brokenWall = getTileItemById(tp, 3494).uid
   if(brokenWall > 0) then
     doRemoveItem(brokenWall)
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

local function addWall(tp)
   local brokenWall = getTileItemById(tp, 3494).uid
   if(brokenWall == 0) then
     Game.createItem(3494, 1, Position(192, 61, 6))
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
   --doCreatureSay(cid, "You have "..monster.time.." seconds to enter the teleport!", TALKTYPE_ORANGE_1)
   addEvent(addWall, monster.time * 1000, monster.wallPos)
   
   return true
end