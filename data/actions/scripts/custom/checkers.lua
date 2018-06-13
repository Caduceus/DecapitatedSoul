local config = {
    items = {2624, 2625, 2631,2637},
    centerCheckerBoardPosition = Position(832, 886, 7),
    playerPositions = {
        Position(831, 878, 6),
        Position(833, 878, 6)
    },
    newPositions = {
        Position(828, 886, 7),
        Position(835, 887, 7)
    },
    whitePos = {
            Position(828, 888, 7),
            Position(830, 888, 7),
            Position(832, 888, 7),
            Position(834, 888, 7),
            Position(829, 889, 7),
            Position(831, 889, 7),
            Position(833, 889, 7),
            Position(835, 889, 7),
            Position(828, 890, 7),
            Position(830, 890, 7),
            Position(832, 890, 7),
            Position(834, 890, 7)
    },
 
    blackPos = {
     
            Position(829, 885, 7),
            Position(831, 885, 7),
            Position(833, 885, 7),
            Position(835, 885, 7),
            Position(828, 884, 7),
            Position(830, 884, 7),
            Position(832, 884, 7),
            Position(834, 884, 7),
            Position(829, 883, 7),
            Position(831, 883, 7),
            Position(833, 883, 7),
            Position(835, 883, 7)
    },
 
    whiteKingPos = {
            Position(828, 881, 7),
            Position(829, 881, 7),
            Position(830, 881, 7),
            Position(831, 881, 7),
            Position(832, 881, 7),
            Position(833, 881, 7),
            Position(834, 881, 7),
            Position(835, 881, 7)
        },
 
    blackKingPos = {
            Position(828, 892, 7),
            Position(829, 892, 7),
            Position(830, 892, 7),
            Position(831, 892, 7),
            Position(832, 892, 7),
            Position(833, 892, 7),
            Position(834, 892, 7),
            Position(835, 892, 7)
        }
    }
function clearRoom()
    iterateArea(function(position)
        local tile = Tile(position)
        if not tile then
            return
        end
        local items = tile:getItems()
        if items then
            for i = 1, #items do
                local item = items[i]
                if isInArray(config.items, item:getId()) then
                item:remove()
                end
            end
        end
    end, 
		Position(826, 879, 7), 
		Position(837, 893, 7)) 
    end
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
        local specs, spec = Game.getSpectators(config.centerCheckerBoardPosition, false, true, 7, 7, 7, 7)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "A match is already in progress. Please try again later.")
                return true
            end
            spec:remove()
        end
        
        clearRoom()
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
            players:setDirection(DIRECTION_SOUTH)
        end
 
    elseif item.itemid == 1946 then
        return true
    end
end