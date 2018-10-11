local config = {  
	requiredLevel = 75,
	daily = false,
	centerStormblastChamber = Position(329, 49, 6),
	playerPositions = {
		Position(1034, 867, 2),
		Position(1036, 867, 2)
	},
	newPositions = {
		Position(329, 54, 6),
		Position(329, 45, 6)
	},
	monsterSpawnPosition = Position(329, 50, 6),
	monsterName = {
        [1] = "Stormblast2",
        [2] = "Stormblast",
        [3] = "Stormblast3"
    }
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item.itemid == 1945 then
	local storePlayers, playerTile = {}

	for i = 1, #config.playerPositions do
		playerTile = Tile(config.playerPositions[i]):getTopCreature()
		if playerTile and playerTile:isPlayer() and playerTile:getLevel() >= config.requiredLevel then
			storePlayers[#storePlayers + 1] = playerTile
		end
	end
 
	if #storePlayers == 0 then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You must be on a tile.")
			return true
	end

		--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
		local specs, spec = Game.getSpectators(config.centerStormblastChamber, false, false, 9, 9, 10, 10)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A battle is currently in progress. Please try again later.")
				return true
			end

			spec:remove()
		end
				
		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:setDirection(DIRECTION_SOUTH)
		end
		if #storePlayers == 2 then
				Game.createMonster(config.monsterName[3], config.monsterSpawnPosition)
			for i = 1, #storePlayers do
				players = storePlayers[i]
				players:sendTextMessage(MESSAGE_INFO_DESCR, "Good luck team!")
				addEvent(broadcastMessage, 1 * 1000, "".. player:getName() .." and ".. players:getName() .." started a team battle on Stormblast!", MESSAGE_STATUS_WARNING)
			return true
		end
			
	elseif #storePlayers == 1 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Good luck, ".. player:getName() .."!")
			addEvent(broadcastMessage, 1 * 1000, "".. player:getName() .." started a solo battle on Stormblast!", MESSAGE_STATUS_WARNING)
		end
		if isInArray({3,4,9}, player:getVocation():getBase():getId()) then
            Game.createMonster(config.monsterName[2], config.monsterSpawnPosition)
        elseif isInArray({1,2}, player:getVocation():getBase():getId()) then
			Game.createMonster(config.monsterName[1], config.monsterSpawnPosition)
		end

	elseif item.itemid == 1945 then
		if config.daily then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
			return true
		end
	end

	item:transform(item.itemid == 1946 and 1945 or 1946)
	return true
end
	