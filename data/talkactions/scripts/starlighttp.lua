local storages = {82001, 82002, 82003}

function onSay(cid, words, param)
     local player = Player(cid)
     local pos = player:getPosition()
     local p = {pos.x, pos.y, pos.z}
     
	if getTileInfo(pos).nologout == true then 
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "This command cannot be used here.")
	return false
    end
    
     for x = 1, 3 do
         player:setStorageValue(storages[x], p[x])
     end
     player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Position set!")
     player:say('Your position has been set!', TALKTYPE_MONSTER_SAY)
     player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
     return false
end