local config = {
    tokens = {2624, 2625, 2631,2637},
   
    centerCheckerBoardPosition = Position(1028, 1078, 15),
   
    playerPositions = {
            --Position(1027, 1071, 15),
            Position(1029, 1071, 15)
    },
    newPositions = {
            --Position(1027, 1079, 15),
            Position(1028, 1079, 15)
    },
   
    area = {
            fromPos = {x = 1020, y = 1070, z = 15},
            toPos = {x = 1033, y = 1086, z = 15}
    },
   
    whitePos = {
            Position(1024, 1080, 15),
            Position(1026, 1080, 15),
            Position(1028, 1080, 15),
            Position(1030, 1080, 15),
            Position(1025, 1081, 15),
            Position(1027, 1081, 15),
            Position(1029, 1081, 15),
            Position(1031, 1081, 15),
            Position(1024, 1081, 15),
            Position(1024, 1082, 15),
            Position(1026, 1082, 15),
            Position(1028, 1082, 15),
            Position(1030, 1082, 15)
    },
       
    blackPos = {
           
            Position(1025, 1075, 15),
            Position(1027, 1075, 15),
            Position(1029, 1075, 15),
            Position(1031, 1075, 15),
            Position(1024, 1076, 15),
            Position(1026, 1076, 15),
            Position(1028, 1076, 15),
            Position(1030, 1076, 15),
            Position(1025, 1077, 15),
            Position(1027, 1077, 15),
            Position(1029, 1077, 15),
            Position(1031, 1077, 15)
    },
       
    whiteKingPos = {
            Position(1025, 1072, 15),
            Position(1026, 1072, 15),
            Position(1027, 1072, 15),
            Position(1028, 1072, 15),
            Position(1029, 1072, 15),
            Position(1030, 1072, 15),
            Position(1025, 1073, 15),
            Position(1026, 1073, 15),
            Position(1027, 1073, 15),
            Position(1028, 1073, 15),
            Position(1029, 1073, 15),
            Position(1030, 1073, 15)
        },
       
    blackKingPos = {
            Position(1025, 1084, 15),
            Position(1026, 1084, 15),
            Position(1027, 1084, 15),
            Position(1028, 1084, 15),
            Position(1029, 1084, 15),
            Position(1030, 1084, 15),
            Position(1025, 1085, 15),
            Position(1026, 1085, 15),
            Position(1027, 1085, 15),
            Position(1028, 1085, 15),
            Position(1029, 1085, 15),
            Position(1030, 1085, 15)
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
 
            storePlayers[#storePlayers + 1] = playerTile
        end
 
        --Game.getSpectators(position[, multifloor = false[, onlyPlayer = false[, minRangeX = 0[, maxRangeX = 0[, minRangeY = 0[, maxRangeY = 0]]]]]])
        local specs, spec = Game.getSpectators(config.centerCheckerBoardPosition, false, true, 6, 6, 6, 6)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "A match is already in progress. Please try again later.")
                return true
            end
 
            spec:remove()
        end
 
        for i = 1, #config.whitePos do
            Game.createItem(2625, 1, config.whitePos[i])
        end
       
        for i = 1, #config.blackPos do
            Game.createItem(2624, 1, config.blackPos[i])
        end
       
        for i = 1, #config.whiteKingPos do
            Game.createItem(2631, 1, config.whiteKingPos[i])
        end
       
        for i = 1, #config.blackKingPos do
            Game.createItem(2637, 1, config.blackKingPos[i])
        end
 
        local players
        for i = 1, #storePlayers do
            players = storePlayers[i]
            config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
            players:teleportTo(config.newPositions[i])
            config.newPositions[i]:sendMagicEffect(CONST_ME_POFF)
            players:setDirection(DIRECTION_WEST)
            item:transform(1946)
        end
       
    elseif item.itemid == 1946 then
             
    iterateArea(
		function(position)
        local tile = Tile(position)
        if not tile then
            return
        end
        local items = tile:getItems()
        if items then
            for i = 1, #config.tokens do
                local item = config.tokens[i]
                item:remove()
            end
        end
	end, Position(1020, 1070, 15), Position(1033, 1086, 15)) 
	
    item:transform(item.itemid == 1946 and 1945 or 1946)
    return true
    end
end