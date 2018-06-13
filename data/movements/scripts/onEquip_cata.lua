function onEquip(player, item, slot)
    if player:getStorageValue(Storage.catacombsComplete) ~= 1 then
		player:say('Don\'t try to cheat!', TALKTYPE_MONSTER_SAY)
		sendChannelMessage(3, TALKTYPE_CHANNEL_R1, "System Message: ".. player:getName() .." is trying to cheat by using ".. item:getName() .." before completing The Catacombs Quest. Shame on you, ".. player:getName() .."!")
		print("> Cheater Alert: " .. player:getName() .. ", tried to use " .. item:getName() .. " illegally.")
        return false
    end
 
    return true
end