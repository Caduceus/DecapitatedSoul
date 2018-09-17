local config = {
	requiredLevel = 100,
	requiredMaxLevel = 200,
	daily = true,
	centerIslandPosition = Position(72, 195, 7),
	playerPositions = {
		Position(1216, 1290, 5),
		Position(1218, 1290, 5)
	},
	newPositions = {
		Position(73, 223, 5),
		Position(85, 223, 5)
	},
	pirate_ghostPositions = {
		Position(76, 202, 7),
		Position(72, 220, 6),
		Position(84, 220, 6),
		Position(80, 213, 6),
		Position(87, 209, 6),
		Position(92, 209, 6),
		Position(76, 202, 6),
		Position(79, 202, 6),
		Position(62, 191, 6),
		Position(79, 210, 5),
		Position(92, 204, 5),
		Position(89, 198, 5),
		Position(74, 189, 5),
		Position(64, 191, 5),
		Position(90, 209, 4),
		Position(86, 201, 4),
		Position(62, 185, 4),
		Position(76, 184, 4),
		Position(71, 177, 4),
		Position(62, 172, 4)
	},
	pirate_skeletonPositions = {
		Position(78, 203, 7),
		Position(75, 219, 6),
		Position(79, 212, 6),
		Position(82, 219, 6),
		Position(90, 208, 6),
		Position(77, 197, 6),
		Position(82, 196, 6),
		Position(60, 189, 6),
		Position(65, 188, 6),
		Position(91, 206, 5),
		Position(75, 191, 5),
		Position(60, 192, 5),
		Position(80, 210, 4),
		Position(82, 201, 4),
		Position(67, 183, 4),
		Position(75, 179, 4),
		Position(67, 176, 4),
		Position(74, 195, 3)
	}
}


function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if item.itemid == 9827 then
		local storePlayers, playerTile = {}

		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			
			if not playerTile or not playerTile:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "You need 2 players.")
				return true
			end
			
			if playerTile:getItemCount(18422) < 10 then
				player:say('Each team member must sacrifice 10 daily tokens to enter!', TALKTYPE_MONSTER_SAY)
				return true
			end
			
			if playerTile:getLevel() < config.requiredLevel or playerTile:getLevel() > config.requiredMaxLevel then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Both players need to be between level ".. config.requiredLevel .." and ".. config.requiredMaxLevel ..".")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end
		local spectators = Game.getSpectators(config.centerIslandPosition, true, true, 45, 45, 45, 45)
			if #spectators > 0 then
				player:say('Wait for the current team to exit.', TALKTYPE_MONSTER_SAY, false, 0, Position(1217, 1290, 5))
			return true
		end

								--multifloor = false, onlyPlayer = false, minRangeX, maxRangeX, minRangeY, maxRangeY)
		local specs, spec = Game.getSpectators(config.centerIslandPosition, true, false, 45, 45, 45, 45)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the quest area.")
				return true
			end
			spec:remove()
		end
		
		for i = 1, #config.pirate_ghostPositions do
			Game.createMonster("dungeon ghost", config.pirate_ghostPositions[i])
		end

		for i = 1, #config.pirate_skeletonPositions do
			Game.createMonster("dungeon skeleton", config.pirate_skeletonPositions[i])
		end
		

		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			players:removeItem(18422, 10)
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_TELEPORT)
			players:setDirection(DIRECTION_NORTH)
		end
	elseif item.itemid == 1945 then
		if config.daily then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
			return true
		end
	end

	item:transform(item.itemid == 9827 and 9828 or 9827)
	return true
end
