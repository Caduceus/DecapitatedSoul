local config = {
	['euryale'] = {amount = 1, storage = 21924, startstorage = 45558, startvalue = 1},
	['mnemosyne'] = {amount = 1, storage = 21925, startstorage = 45558, startvalue = 1},
	['sthenno'] = {amount = 1, storage = 21926, startstorage = 45558, startvalue = 1},
	
	summonPositions = {
		{x = 184, y = 70, z = 6},
		{x = 192, y = 62, z = 6},
		{x = 200, y = 70, z = 6},
		{x = 192, y = 70, z = 6},
		{x = 192, y = 78, z = 6}
	}
} 
	
local function getRandomSummonPosition()
	return config.summonPositions[math.random(#config.summonPositions)]
end
	
function onKill(player, target)
     local monster = config[target:getName():lower()]
     if target:isPlayer() or not monster or target:getMaster() then
         return true
     end
     local stor = player:getStorageValue(monster.storage)+1
     if stor < monster.amount and player:getStorageValue(monster.startstorage) >= monster.startvalue then
         player:setStorageValue(monster.storage, 1)
         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, ''..target:getName()..' was killed.')
     end
     --if (stor +1) == monster.amount then
     if player:getStorageValue(21924) == 1 and player:getStorageValue(21925) == 1 and player:getStorageValue(21926) == 1 then
         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Oh snap, watch out...')
         Game.createMonster('medusa', getRandomSummonPosition(), false, true)
         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'rawr!')
     end
     return true
end