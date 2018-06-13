
local config = {  
	requiredLevel = 350,
	daily = true,
	centerDemonRoomPosition = Position(82, 71, 6),
	playerPositions = {
		Position(1215, 643, 9),
		Position(1217, 643, 9)
	},
	newPositions = {
		Position(119, 76, 6),
		Position(119, 78, 6)
	},
	snakePositions = {
		Position(95, 87, 6),
		Position(84, 83, 6),
		Position(82, 83, 6),
		Position(85, 79, 6),
		Position(82, 79, 6),
		Position(98, 77, 6),
		Position(96, 74, 6),
		Position(100, 69, 6),
		Position(112, 60, 6),
		Position(115, 77, 6),
		Position(102, 61, 6),
		Position(102, 58, 6),
		Position(97, 57, 6),
		Position(97, 63, 6),
		Position(89, 59, 6),
		Position(81, 62, 6),
		Position(72, 60, 6),
		Position(65, 60, 6),
		Position(66, 59, 6),
		Position(62, 49, 6),
		Position(61, 49, 6),
		Position(57, 64, 6),
		Position(56, 66, 6),
		Position(50, 74, 6),
		Position(51, 77, 6),
		Position(50, 82, 6),
		Position(50, 85, 6),
		Position(53, 84, 6),
		Position(60, 89, 6),
		Position(59, 94, 6),
		Position(53, 80, 7),
		Position(56, 77, 7),
		Position(63, 77, 7),
		Position(66, 76, 7),
		Position(73, 78, 7),
		Position(78, 77, 7),
		Position(85, 78, 7),
		Position(111, 87, 7),
		Position(94, 86, 7),
		Position(101, 87, 7),
		Position(103, 93, 7),
		Position(96, 99, 7),
		Position(95, 96, 7),
		Position(92, 96, 7)
	},
	godPositions = {
		Position(114, 77, 6),
		Position(100, 74, 6),
		Position(112, 58, 6),
		Position(98, 61, 6),
		Position(85, 62, 6),
		Position(61, 55, 6),
		Position(54, 74, 6),
		Position(58, 86, 6),
		Position(94, 92, 6),
		Position(54, 79, 7),
		Position(70, 81, 7),
		Position(88, 84, 7),
		Position(105, 87, 7),
		Position(99, 97, 7)
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
			
			if playerTile:getItemCount(18422) < 10 then
				player:say('Each team member must sacrifice 10 daily tokens to enter!', TALKTYPE_MONSTER_SAY)
				return true
			end
			
			if playerTile:getStorageValue(15010) > os.time() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "" .. playerTile:getName() .. " has completed this quest within the past 24 hours.")
				return true
			end

			if playerTile:getLevel() < config.requiredLevel then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Both players need to be level ".. config.requiredLevel .." or higher.")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end

		--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, true, false, 37, 37, 23, 26)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the quest area. Please try again later.")
				return true
			end

			spec:remove()
		end

		for i = 1, #config.snakePositions do
			Game.createMonster("medusa snake", config.snakePositions[i])
		end
		
		for i = 1, #config.godPositions do
			Game.createMonster("snake god essence", config.godPositions[i])
		end

		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			players:removeItem(18422, 10)
			players:setStorageValue(15010, -1)
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:setDirection(DIRECTION_WEST)
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
