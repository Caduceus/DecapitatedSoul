local config = {
	requiredLevel = 125,
	daily = true,
	centerDemonRoomPosition = Position(704, 699, 8),
	playerPositions = {
		Position(706, 708, 7),
		Position(704, 708, 7)
	},
	newPositions = {
		Position(705, 708, 8),
		Position(703, 708, 8)
	},
	demonPositions = {
		Position(704, 712, 8),
		Position(702, 708, 8),
		Position(704, 707, 8),
		Position(706, 708, 8)
	},
	banshePositions = {
		Position(701, 705, 8),
		Position(707, 705, 8),
		Position(701, 710, 8),
		Position(707, 710, 8),
		Position(700, 712, 8),
		Position(701, 713, 8),
		Position(707, 713, 8),
		Position(708, 712, 8)
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
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "All the players need to be level ".. config.requiredLevel .." or higher.")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end
		--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 20, 20, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the quest room.")
				return true
			end

			spec:remove()
		end

		for i = 1, #config.demonPositions do
			Game.createMonster("Demon", config.demonPositions[i])
		end
		
		for i = 1, #config.banshePositions do
			Game.createMonster("Banshee", config.banshePositions[i])
		end

		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_EAST)
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