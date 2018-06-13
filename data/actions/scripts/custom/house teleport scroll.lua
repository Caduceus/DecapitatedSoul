function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:say('You cant teleport whilst in battle!', TALKTYPE_MONSTER_SAY)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    return true
    end
    
    local house = player:getHouse()
	if house == nil then
	player:sendCancelMessage("You do not own a house.")
		return true
	end

		player:teleportTo(house:getExitPosition())
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
	end