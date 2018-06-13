local config = {
	requiredLevel = 350,
	daily = true,
	centerMedusaArenaPosition = Position(192, 70, 6),
	playerPositions = {
		Position(82, 76, 6),
		Position(84, 76, 6)
	},
	newPositions = {
		Position(190, 70, 6),
		Position(194, 70, 6)
	},
	snakePositions = {
		Position(185, 65, 6),
		Position(192, 62, 6),
		Position(199, 65, 6),
		Position(185, 75, 6),
		Position(193, 78, 6),
		Position(200, 73, 6)
	}
}


function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item.itemid == 1945 then
		local storePlayers, playerTile = {}

		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			
			if not playerTile or not playerTile:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "You need 2 players.")
				return true
			end
			
			if playerTile:getLevel() < config.requiredLevel then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Both players need to be level ".. config.requiredLevel .." or higher.")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end

		--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
		local specs, spec = Game.getSpectators(config.centerMedusaArenaPosition, false, false, 10, 10, 10, 10)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the quest area.")
				return true
			end

			spec:remove()
		end

		for i = 1, #config.snakePositions do
			Game.createMonster("medusa snake", config.snakePositions[i])
		end
		
		Game.createMonster("euryale", Position(190, 71, 6))
		Game.createMonster("mnemosyne", Position(192, 69, 6))
		Game.createMonster("sthenno", Position(194, 71, 6))
		
		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			players:setStorageValue(45558, 1)
			players:setStorageValue(21924, -1)
			players:setStorageValue(21925, -1)
			players:setStorageValue(21926, -1)
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_POFF)
			
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
