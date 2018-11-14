local config = {
	 ['rotworm'] = {amount = 50, storage = 19000, startstorage = 5010, startvalue = 1},
	 ['carrion worm'] = {amount = 50, storage = 19001, startstorage = 5011, startvalue = 1},
	 ['amazon'] = {amount = 50, storage = 19002, startstorage = 5012, startvalue = 1},
	 ['cyclops'] = {amount = 50, storage = 19003, startstorage = 5013, startvalue = 1},
	 ['dragon hatchling'] = {amount = 50, storage = 19004, startstorage = 5014, startvalue = 1},
	 ['dragon lord hatchling'] = {amount = 50, storage = 19004, startstorage = 5014, startvalue = 1},
	 ['hero'] = {amount = 50, storage = 19005, startstorage = 5015, startvalue = 1},
     ['dragon'] = {amount = 50, storage = 19006, startstorage = 5016, startvalue = 1},
     ['dragon lord'] = {amount = 50, storage = 19007, startstorage = 5017, startvalue = 1},
     ['demodras'] = {amount = 50, storage = 19008, startstorage = 5018, startvalue = 1},
     ['hydra'] = {amount = 50, storage = 19009, startstorage = 5019, startvalue = 1},
     ['demon'] = {amount = 50, storage = 19010, startstorage = 5020, startvalue = 1},
     ['warlock'] = {amount = 50, storage = 19011, startstorage = 5021, startvalue = 1},
     ['orshabaal'] = {amount = 50, storage = 19012, startstorage = 5022, startvalue = 1},
     ['lost soul'] = {amount = 50, storage = 19013, startstorage = 5023, startvalue = 1},
     ['chocobo warrior'] = {amount = 50, storage = 19014, startstorage = 5024, startvalue = 1},
     ['ghastly dragon'] = {amount = 50, storage = 19015, startstorage = 5025, startvalue = 1},
     ['frost dragon'] = {amount = 50, storage = 19016, startstorage = 5026, startvalue = 1},
     ['grim reaper'] = {amount = 50, storage = 19017, startstorage = 5027, startvalue = 1},
     ['juggernaut'] = {amount = 50, storage = 19018, startstorage = 5028, startvalue = 1},
     ['vampire'] = {amount = 50, storage = 19019, startstorage = 5029, startvalue = 1},
     ['apocalypse'] = {amount = 50, storage = 19020, startstorage = 5030, startvalue = 1},
     ['morgaroth'] = {amount = 50, storage = 19021, startstorage = 5031, startvalue = 1},
     ['infernatil'] = {amount = 50, storage = 19022, startstorage = 5032, startvalue = 1},
     ['trigama'] = {amount = 50, storage = 19023, startstorage = 5033, startvalue = 1}
     
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
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'Congratulations, you have killed '..(stor +1)..' '..target:getName()..'s and completed the '..target:getName()..'s mission.')
        player:setStorageValue(monster.storage, stor +1)
    end
    return true
end
