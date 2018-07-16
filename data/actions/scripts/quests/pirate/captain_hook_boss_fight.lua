   local config = {
	requiredLevel = 80,
	requiredMaxLevel = 150,
	centerIslandPosition = Position(1271, 1268, 6),
	playerPositions = {
		--Position(1249, 1242, 5),
		Position(1251, 1242, 5)
	},
	startPositions = {
		--Position(1267, 1294, 5),
		--Position(1279, 1294, 5)
	},
	newPositions = {
		--Position(1241, 1248, 5),
		--Position(1254, 1249, 5)
		Position(1262, 1246, 4)
	},
	--[[pirate_skeletonPositions = {
		Position(1266, 1293, 6),
		Position(1278, 1293, 6)
	},
	pirate_ghostPositions = {
		Position(1266, 1293, 6),
		Position(1278, 1293, 6)
	},]]--
	captain_hookPositions = {
		Position(1256, 1244, 4)
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
			
			--[[if playerTile:getLevel() > config.requiredMaxLevel then 
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Both players need to be between level ".. config.requiredLevel .." and ".. config.requiredMaxLevel ..".")
				return true
			end]]--
			
			if playerTile:getLevel() < config.requiredLevel then 
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Both players need to be between level ".. config.requiredLevel .." and ".. config.requiredMaxLevel ..".")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end
		--Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
		--[[local specs, spec = Game.getSpectators(config.centerIslandPosition, true, false, 18, 23, 25, 30)
		for i = 1, #specs do
            spec = specs[i]
            if spec:isMonster() then
				player:teleportTo(config.startPositions[i])
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You did not kill all of the monsters!")
				return true
				end
			end  
        end ]]
            
		--[[for i = 1, #config.pirate_skeletonPositions do
			Game.createMonster("pirate skeleton", config.pirate_skeletonPositions[i])
		end]]--
		
		Game.createMonster("captain hook", Position(1256, 1244, 4))
				
		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			--players:removeItem(18422, 10)
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:sendTextMessage(MESSAGE_INFO_DESCR, "test")
			players:setDirection(DIRECTION_SOUTH)
			return true
		end
	end		

	item:transform(item.itemid == 9827 and 9828 or 9827)
	return true
end
