local config = {
    ['dragon hatchling'] = {amount = 20, storage = 21900, startstorage = 45551, startvalue = 2},
	['dragon lord hatchling'] = {amount = 20, storage = 21901, startstorage = 45551, startvalue = 2},
	--['vampire'] = {amount = 50, storage = 21902, startstorage = 45551, startvalue = 4},
	['stormblast'] = {amount = 1, storage = 21903, startstorage = 45551, startvalue = 5},
     -- Damon
    ['carrion worm'] = {amount = 10, storage = 21904, startstorage = 45560, startvalue = 1},
     -- Tits
    ['hero'] = {amount = 20, storage = 21905, startstorage = 45553, startvalue = 1},
     -- addon
    ['rat'] = {amount = 15, storage = 21906, startstorage = 45554, startvalue = 1},
     -- The Gatekeeper
    ['skeleton'] = {amount = 15, storage = 21907, startstorage = 45555, startvalue = 1},
     -- Lilith
    ['hydra'] = {amount = 100, storage = 21908, startstorage = 45556, startvalue = 1},
    ['demodras'] = {amount = 100, storage = 21909, startstorage = 45556, startvalue = 2},
    ['warlock'] = {amount = 100, storage = 21910, startstorage = 45556, startvalue = 3},
	['infernalist'] = {amount = 50, storage = 21911, startstorage = 45556, startvalue = 3},
	['fury'] = {amount = 50, storage = 21912, startstorage = 45556, startvalue = 3},
	['lost soul'] = {amount = 100, storage = 21914, startstorage = 45556, startvalue = 4},
	['dark torturer'] = {amount = 40, storage = 21915, startstorage = 45556, startvalue = 4},
	['demon'] = {amount = 100, storage = 21913, startstorage = 45556, startvalue = 5},
	['orshabaal'] = {amount = 50, storage = 21916, startstorage = 45556, startvalue = 6},
	['juggernaut'] = {amount = 50, storage = 21917, startstorage = 45556, startvalue = 7},
	['ghastly dragon'] = {amount = 50, storage = 21918, startstorage = 45556, startvalue = 8},
	['frost dragon'] = {amount = 50, storage = 21919, startstorage = 45556, startvalue = 9},
	['angel of death'] = {amount = 1, storage = 21921, startstorage = 45556, startvalue = 10},
	--Keaton
	['rotworm'] = {amount = 20, storage = 21922, startstorage = 45557, startvalue = 1},
	--Javy Dones
	['captain hook'] = {amount = 1, storage = 21923, startstorage = 2239, startvalue = 4},
	--Keaton
	['black knight'] = {amount = 20, storage = 21927, startstorage = 45559, startvalue = 1},
							

}
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
         player:sendTextMessage(MESSAGE_INFO_DESCR, 'Congratulations, you have killed '..(stor +1)..' '..target:getName()..'s.')
         player:setStorageValue(monster.storage, stor +1)
     end
     return true
end