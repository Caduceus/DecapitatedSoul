local timetoreset = 5 -- Time to reset the quest in minutes.
local objectid = 1498 -- Id of the item Blocking the path
local p = {
	Position(1034, 613, 14), -- Position of the item blocking the path
	Position(1038, 610, 14), -- Teleport Creation position
	Position(931, 676, 13) -- Position where it sends you
}

function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
	local stone = Tile(p[1])
	local tp = Tile(p[2])
	if item.itemid == 1945 then
		cid:sendTextMessage(MESSAGE_EVENT_ORANGE, 'The magic wall has dissapeared for ' .. timetoreset .. ' minutes.')
		doCreateTeleport(1387, p[3], p[2])
        stone:getItemById(objectid):remove()
		p[1]:sendMagicEffect(CONST_ME_POFF)
		p[2]:sendMagicEffect(CONST_ME_TELEPORT)
        Item(item.uid):transform(1946) 
		
        addEvent(function(stonePos)
            Game.createItem(objectid, 1, stonePos)
			stonePos:sendMagicEffect(CONST_ME_TELEPORT)
            p[2]:sendMagicEffect(CONST_ME_POFF)
			tp:getItemById(1387):remove()
            Tile(toPosition):getItemById(1946):transform(1945)             
        end, timetoreset * 60000, stone:getPosition())
		
    elseif item.itemid == 1946 then
        return false
    end
    return true
end