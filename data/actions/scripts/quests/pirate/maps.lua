local firePos = {
            [1] = {x=1151, y=1238, z=7, stackpos=2},
            [2] = {x=1194, y=1243, z=7, stackpos=3},
            [3] = {x=1216, y=1290, z=7, stackpos=1},
            [4] = {x=1145, y=1320, z=7, stackpos=3}
        }
local time_ = 10
local function removeFire1()
		doRemoveItem(getThingfromPos(firePos[1]).uid)
	end
local function removeFire2()
		doRemoveItem(getThingfromPos(firePos[2]).uid)
	end
local function removeFire3()
		doRemoveItem(getThingfromPos(firePos[3]).uid)
	end
local function removeFire4()
		doRemoveItem(getThingfromPos(firePos[4]).uid)
	end
local storageMap1 = 1015
local storageMap2 = 1016
local storageMap3 = 1017
local storageMap4 = 1018

local mapPos1 = Position(1151, 1238, 7)
local mapPos2 = Position(1194, 1243, 7)
local mapPos3 = Position(1216, 1290, 7)
local mapPos4 = Position(1145, 1320, 7)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

if target.uid == 9012 then
	if player:getStorageValue(storageMap1) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos1)
				addEvent(removeFire1, time_ * 1000)
				player:setStorageValue(storageMap1, 1)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have burnt the map.")
	end
	
	elseif target.uid == 9013 then
		if player:getStorageValue(storageMap2) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos2)
				addEvent(removeFire2, time_ * 1000)
				player:setStorageValue(storageMap2, 1)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have burnt the map.")
	end
	
	elseif target.uid == 9014 then
		if player:getStorageValue(storageMap3) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos3)
				addEvent(removeFire3, time_ * 1000)
				--player:setStorageValue(storageMap3, 1)
				player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have burnt the map.")
	end
	
	elseif target.uid == 9015 then
		if player:getStorageValue(storageMap4) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already burnt this map.")
	else
				Game.createItem(1489, 1, mapPos4)
				addEvent(removeFire4, time_ * 1000)
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
