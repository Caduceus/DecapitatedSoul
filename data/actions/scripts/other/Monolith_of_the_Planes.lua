local blink = {35918,35919,35920}
local turnOff = {[35917] = 35921}
 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local transformItem = turnOff[item.itemid]
		if transformItem then
			item:transform(transformItem)
		return true
	end
	
	if isInArray(blink, item:getId()) then 
		item:transform(35917)
	return true
	end

	local lightOff = item:getId(35921)
	local randomValue = math.random(1, 3)
		if lightOff and randomValue == 1 then
			item:transform(35920)
		elseif lightOff and randomValue == 2 then
			item:transform(35919)
		elseif lightOff and randomValue == 3 then
			item:transform(35918)
		return true
	end 
end