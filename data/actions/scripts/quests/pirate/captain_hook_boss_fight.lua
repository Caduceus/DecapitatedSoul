   local config = {
	requiredLevel = 80,
	requiredMaxLevel = 150,
	centerIslandPosition = Position(72, 195, 7),
	playerPositions = {
		Position(55, 171, 5),
		--Position(57, 171, 5)
	},
	newPositions = {
		Position(47, 177, 5),
		--Position(60, 178, 5)
	},
	pirate_skeletonPositions = {
		Position(48, 177, 5)
	},
	pirate_ghostPositions = {
		Position(57, 178, 5)
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
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "Both players need to be between level ".. config.requiredLevel .." and ".. config.requiredMaxLevel ..".")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end
		
		local specs, spec = Game.getSpectators(config.centerIslandPosition, true, false, 45, 45, 45, 45)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isMonster() then
				player:say('You must clear all monsters to advance.', TALKTYPE_MONSTER_SAY, false, 0, Position(56, 171, 5))
                return true
            end  
	   end
		
		for i = 1, #config.pirate_ghostPositions do
			Game.createMonster("dungeon ghost", config.pirate_ghostPositions[i])
		end

		for i = 1, #config.pirate_skeletonPositions do
			Game.createMonster("dungeon skeleton", config.pirate_skeletonPositions[i])
		end
		
		Game.createMonster("captain hook", Position(71, 192, 7))
				
		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
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
