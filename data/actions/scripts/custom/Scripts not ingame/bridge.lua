local function reset(p)
   doTransformItem(getTileItemById(p, 1946).uid, 1945)
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
   local endPos = {x = 1059, y = 911, z = 6} 
   local startPos = {x = 1057, y = 917, z = 6} 

   -- check if player has required level.
   if getPlayerLevel(cid) < 80 then
     return doPlayerSendCancel(cid, "You don't have the required level.")
   end

   -- check if player is standing on correct square
   local standPos = getCreaturePosition(cid)
   if (standPos.x ~= startPos.x or standPos.y ~= startPos.y or standPos.z ~= startPos.z) then
     return doPlayerSendCancel(cid, "You are required to stand on the pressure plate to use this lever.")
   end

   -- check if lever is currently used
   if item.itemid == 1946 then
     return doPlayerSendTextMessage(cid, 21, "Wait for switch to reset.")
   end

   -- if everything checks out fine..

   -- transform lever, and add reset
   doTransformItem(item.uid, item.itemid + 1)
   addEvent(reset, 10 * 1000, toPosition)

   -- teleport player, send message and effect
   doTeleportThing(cid, endPos, true)
   doPlayerSendTextMessage(cid, 22, "Happy Hunting!")
   doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)

   return true
end