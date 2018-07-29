local boatids = {3589, 3594}
 
function onStepIn(cid, item, position, fromPosition)
 
   for _, id in pairs(boatids) do
     if getTileItemById(fromPosition, id).uid > 0 then
       return doTeleportThing(cid, fromPosition)
     end
   end
   return true
end
