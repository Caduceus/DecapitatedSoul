local turnOff = {
    [29624] = 29623,    
    [29625] = 29623,    
    [29626] = 29623    
}
 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local transformItem = turnOff[item.itemid]
		if transformItem then
			item:transform(transformItem)
		return true
	end

	local lightOff = item:getId(29623)
	local randomValue = math.random(1, 3)
		if lightOff and randomValue == 1 then
			item:transform(29624)
			return true
		end
		if lightOff and randomValue == 2 then
			item:transform(29625)
			return true
		end
		if lightOff and randomValue == 3 then
			item:transform(29626)
			return true
		end 
	end
