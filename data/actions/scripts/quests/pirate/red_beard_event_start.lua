local config = {
	requiredLevel = 80,
	requiredMaxLevel = 150,
	daily = true,
	centerIslandPosition = Position(1259, 1274, 6),
	playerPositions = {
		Position(1216, 1290, 5),
		Position(1218, 1290, 5)
	},
	newPositions = {
		Position(1267, 1294, 5),
		Position(1279, 1294, 5)
	},
	pirate_skeletonPositions = {
		Position(1266, 1293, 6),
		Position(1278, 1293, 6)
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

		--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
		local specs, spec = Game.getSpectators(config.centerIslandPosition, true, false, 20, 20, 20, 20)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the quest area.")
				return true
			end

			spec:remove()
		end

		for i = 1, #config.pirate_skeletonPositions do
			Game.createMonster("pirate skeleton", config.pirate_skeletonPositions[i])
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