function onUse(cid, item, fromPosition, itemEx, toPosition) --needs rewritten
if item.uid == 10034 then 
if item.itemid == 1740 then
local storage = 10034

if player.itemid > 0 then


	if getPlayerStorageValue(cid, storage) < 1 then 
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have received the Dragon Lord Hatchling Mount!")
doPlayerAddMount(cid, 34)
setPlayerStorageValue(cid, storage, 1 )
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have already received that mount.")
end

return TRUE
end 
end
end
end
