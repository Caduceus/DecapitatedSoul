local config = {
	['soul reaper'] = {amount = 20, storage = 21920, startstorage = 45556, startvalue = 10},
	
	summonPositions = {
		{x = 520, y = 1347, z = 10},
		{x = 520, y = 1357, z = 10},
		{x = 520, y = 1367, z = 10},
		{x = 520, y = 1377, z = 10}
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
         player:setStorageValue(monster.storage, stor)
         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Task message: '..(stor +1)..' of '..monster.amount..' '..target:getName()..'s killed.')
     end
     if (stor +1) == monster.amount then
         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Congratulations, you have killed '..(stor +1)..' '..target:getName()..'s and summoned the Angel of Death.')
         player:setStorageValue(monster.storage, stor +1)
         Game.createMonster('angel of death', getRandomSummonPosition(), false, true)
         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The Angel of Death has risen! Your time is up!')
     end
     return true
end