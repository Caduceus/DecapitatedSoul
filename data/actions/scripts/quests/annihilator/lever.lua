local config = {
	requiredLevel = 1,
	daily = false,
	centerDemonRoomPosition = Position(1060, 670, 9),
	playerPositions = {
		Position(1064, 683, 9),
		Position(1064, 684, 9),
		Position(1064, 685, 9),
		Position(1064, 686, 9)
	},
	newPositions = {
		Position(1061, 670, 9),
		Position(1060, 670, 9),
		Position(1059, 670, 9),
		Position(1058, 670, 9)
	},
	demonPositions = {
		Position(1058, 668, 9),
		Position(1060, 668, 9),
		Position(1059, 672, 9),
		Position(1061, 672, 9),
		Position(1062, 670, 9),
		Position(1063, 670, 9)
	}
}


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1946 then
		local storePlayers, playerTile = {}

		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not playerTile or not playerTile:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "You need 4 players.")
				return true
			end

			if playerTile:getLevel() < config.requiredLevel then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "All the players need to be level ".. config.requiredLevel .." or higher.")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end

		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 3, 3, 2, 2)
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