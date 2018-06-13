function onEquip(player, item, slot)
    if player:getStorageValue(2092) ~= 1 then
		if slot:isContainer() then
		player:say('Don\'t try to cheat!', TALKTYPE_MONSTER_SAY)
        return false
    end
 end
 
    return true
end