local liquidContainers = {1775, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015, 2023, 2031, 2032, 2033}
local millstones = {1381, 1382, 1383, 1384}
local ovens = {1786, 6356, 6358, 6360, 6362}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2692 and isInArray(liquidContainers, target.itemid) then
		if target.type == 1 then
			item:transform(item.itemid, item.type - 1)
			player:addItem(2693, 1)
			target:transform(target.itemid, 0)
		elseif target.type == 6 then
			item:transform(item.itemid, item.type - 1)
			player:addItem(6277, 1)
			target:transform(target.itemid, 0)
		end
	elseif item.itemid == 8846 and isInArray(ovens, target.itemid) then
			item:transform(8847)
		elseif target.itemid == 6574 then
			item:transform(8846)
			target:remove()
	elseif item.itemid == 6277 and isInArray(ovens, target.itemid) then
	local cakeCookie = math.random(1, 10)
		if cakeCookie >= 5 then
			item:transform(2687, math.random(1, 12)) 
		else
			item:transform(6278)
		end
	elseif item.itemid == 2693 and isInArray(ovens, target.itemid) then
		item:transform(2689)
	elseif isInArray(millstones, target.itemid) then
		item:transform(item.itemid, item.type - 1)
		player:addItem(2692, 1)
	else
		return false
	end

	return true
end
