local config = {
   ["king koopa"] = {time = 20, toPos = {x = 1100, y = 994, z = 9}, tpPos = {x = 1101, y = 997, z = 10}}, --first toPos is where tp goes, second tpPos is tp position on map.
   ["angel of death"] = {time = 120, toPos = {x = 520, y = 1335, z = 10}, tpPos = {x = 520, y = 1347, z = 10}},
   ["stormblast"] = {time = 120, toPos = {x = 419, y = 56, z = 6}, tpPos = {x = 321, y = 49, z = 6}},
   ["medusa"] = {time = 120, toPos = {x = 1218, y = 637, z = 9}, tpPos = {x = 193, y = 59, z = 6}},
   ["captain hook"] = {time = 120, toPos = {x = 1217, y = 1289, z = 5}, tpPos = {x = 80, y = 191, z = 7}},
}
local function deleteTeleport(tp)
   local teleport = getTileItemById(tp, 1387).uid
   if(teleport > 0) then
     doRemoveItem(teleport)
     doSendMagicEffect(tp, CONST_ME_POFF)
   end
   return true
end

function onKill(cid, target)
   local monster = config[getCreatureName(target):lower()]

   if(isPlayer(target) or not monster) then
     return true
   end
   doCreateTeleport(1387, monster.toPos, monster.tpPos)
   doCreatureSay(cid, "You have "..monster.time.." seconds to enter "..target:getName().."'s teleport!", TALKTYPE_ORANGE_1)
   addEvent(deleteTeleport, monster.time * 1000, monster.tpPos)
   return true
end