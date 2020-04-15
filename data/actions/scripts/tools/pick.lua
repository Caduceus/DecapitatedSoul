local groundIds = {468, 481, 483, 8060}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if toPosition.x == CONTAINER_POSITION then
		return false
	end

	local tile = Tile(toPosition)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground then
		return false
	end
	
	local time_ = 4
	local function resetRockPile()
		ground:transform(8060)
		ground:setActionId(15114)
	end
	
	if ground:getActionId() == 15114 and player:getLevel() < 500 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't seem to be strong enough to open the hole. \n Level 500 required.")
		return false
	end

	if ground:getActionId() == 15114 and player:getLevel() >= 500 then
		ground:transform(385)
		addEvent(resetRockPile, time_ * 1000)
		return true
	end
	
	if (ground.uid > 65535 or ground.actionid == 0) and not isInArray(groundIds, ground.itemid) and ground:getActionId() ~= 15114 then
		return false
	end
		ground:transform(392)
		ground:decay()

		toPosition.z = toPosition.z + 1
		tile:relocateTo(toPosition)
		return true
	end
