function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end
    
    if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:say('You cant teleport whilst in battle!', TALKTYPE_MONSTER_SAY)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    return true
    end
    
    local house = player:getHouse()
    if item.actionid == 16012 then
	if house == nil then
	player:sendCancelMessage("You do not own a house.")
		return true
	end

		player:teleportTo(house:getExitPosition())
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
	end
end