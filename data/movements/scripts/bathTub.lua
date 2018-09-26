local outfit = 28407

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	
	local tile = Tile(position)
	if tile:getCreatureCount() ~= 1 then
		creature:teleportTo(fromPosition, false)
   		creature:sendCancelMessage("Only one person at a time.")
		return true
	end
	
	local outfitCondition = Condition(CONDITION_OUTFIT, CONDITIONID_COMBAT)
		outfitCondition:setTicks(-1)
		outfitCondition:setOutfit(outfit)
		creature:addCondition(outfitCondition)
	return true
end

function onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if player == nil then
		return false
	end

	player:removeCondition(CONDITION_OUTFIT)
	return true
end
