local config = {
	requiredLevel = 80,
	requiredMaxLevel = 150,
	daily = true,
	centerIslandPosition = Position(72, 195, 7),
	playerPositions = {
		Position(1216, 1290, 5),
		--Position(1218, 1290, 5)
	},
	newPositions = {
		Position(73, 223, 5),
		--Position(85, 223, 5)
	},
	pirate_ghostPositions = {
		Position(72, 220, 6),
		Position(84, 220, 6)
	},
	pirate_skeletonPositions = {
		Position(75, 219, 6),
		Position(82, 219, 6)
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
			
			--[[if playerTile:getItemCount(18422) < 10 then
				player:say('Each team member must sacrifice 10 daily tokens to enter!', TALKTYPE_MONSTER_SAY)
				return true
			end]]
			
			--or playerTile:getLevel() > config.requiredMaxLevel then
			
			if playerTile:getLevel() < config.requiredLevel then 
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
		
		for i = 1, #config.pirate_skeletonPositions do
			Game.createMonster("dungeon ghost", config.pirate_skeletonPositions[i])
		end

		for i = 1, #config.pirate_skeletonPositions do
			Game.createMonster("dungeon skeleton", config.pirate_skeletonPositions[i])
		end
		

		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			--players:removeItem(18422, 10)
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
