local monsters = {
	 ['rotworm'] = {storage = 19000, startstorage = 5010},
	 ['carrion worm'] = {storage = 19001, startstorage = 5011},
	 ['amazon'] = {storage = 19002, startstorage = 5012},
	 ['cyclops'] = {storage = 19003, startstorage = 5013},
	 ['dragon hatchling'] = {storage = 19004, startstorage = 5014},
	 ['dragon lord hatchling'] = {storage = 19004, startstorage = 5014},
	 ['hero'] = {storage = 19005, startstorage = 5015},
     ['dragon'] = {storage = 19006, startstorage = 5016},
     ['dragon lord'] = {storage = 19007, startstorage = 5017},
     ['demodras'] = {storage = 19008, startstorage = 5018},
     ['hydra'] = {storage = 19009, startstorage = 5019},
     ['demon'] = {storage = 19010, startstorage = 5020},
     ['warlock'] = {storage = 19011, startstorage = 5021},
     ['orshabaal'] = {storage = 19012, startstorage = 5022},
     ['lost soul'] = {storage = 19013, startstorage = 5023},
     ['chocobo warrior'] = {storage = 19014, startstorage = 5024},
     ['ghastly dragon'] = {storage = 19015, startstorage = 5025},
     ['frost dragon'] = {storage = 19016, startstorage = 5026},
     ['grim reaper'] = {storage = 19017, startstorage = 5027},
     ['juggernaut'] = {storage = 19018, startstorage = 5028},
     ['vampire'] = {storage = 19019, startstorage = 5029},
     ['apocalypse'] = {storage = 19020, startstorage = 5030},
     ['morgaroth'] = {storage = 19021, startstorage = 5031},
     ['infernatil'] = {storage = 19022, startstorage = 5032},
     ['trigama'] = {storage = 19023, startstorage = 5033},
     ['bull worm'] = {storage = 19024, startstorage = 5034}
}
function onThink(player)
	if player:getStorageValue(62004) == -1 then
else
	if player:getStorageValue(62004) < os.time() then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Your Daily Quest Has Expired.')
	for k, x in pairs(monsters) do
		player:setStorageValue(62003, -1) -- Adonai
		player:setStorageValue(62004, -1) -- Expire Storage
		player:setStorageValue(62005, -1) -- Zagorim
		player:setStorageValue(62006, -1) -- Willy
		player:setStorageValue(x.storage, -1)
		player:setStorageValue(x.startstorage, -1)
		player:save()
			end
		end
	end
	return true
end
