function onSay(cid, word, param)
local player = Player(cid)
    if not player then
        return true
    end

	if not player:isVip() then 
		player:sendTextMessage(MESSAGE_STATUS_WARNING,"You do not have a VIP account.")
		return true 
	end
   
	if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING,"You cannot teleport whilst in battle!")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

		player:teleportTo(player:getTown():getTemplePosition())
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return false
	end