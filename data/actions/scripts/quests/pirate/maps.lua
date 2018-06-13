local storageMap1 = 1015
local storageMap2 = 1016
local storageMap3 = 1017
local storageMap4 = 1018

local mapPos1 = Position(1151, 1238, 7)
local mapPos2 = Position(1194, 1243, 7)
local mapPos3 = Position(1218, 1288, 5)
local mapPos4 = Position(1145, 1320, 7)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

if target.uid == 9012 then
	if player:getStorageValue(storageMap1) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos1)
				player:setStorageValue(storageMap1, 1)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have burnt the map.")
	end
	
	elseif target.uid == 9013 then
		if player:getStorageValue(storageMap2) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos2)
				player:setStorageValue(storageMap2, 1)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have burnt the map.")
	end
	
	elseif target.uid == 9014 then
		if player:getStorageValue(storageMap3) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos3)
				player:setStorageValue(storageMap3, 1)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have burnt the map.")
	end
	
	elseif target.uid == 9015 then
		if player:getStorageValue(storageMap4) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos4)
				player:setStorageValue(storageMap4, 1)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have burnt the map.")
	end
	return false
	end
end
	 local player = Player(cid)
    if not player then
        return true
    end
		if player:getStorageValue(storageMap1) == 1 then
		if player:getStorageValue(storageMap2) == 1 then
		if player:getStorageValue(storageMap3) == 1 then
		if player:getStorageValue(storageMap4) == 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'All the Maps are Burnt. Return to Quest Giver!')
	end
	return false
	end
end
end
