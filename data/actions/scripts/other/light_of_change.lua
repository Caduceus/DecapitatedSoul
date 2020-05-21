local turnOff = {
    [29624] = 29623,    
    [29625] = 29623,    
    [29626] = 29623, 
    [29627] = 29623   
}
 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local transformItem = turnOff[item.itemid]
		if transformItem then
			if player:getStorageValue(Storage.lightBearerComplete) ~= 1 then
				player:sendTextMessage(MESSAGE_INFO_DESCR, "I'm sorry ".. player:getName() ..", you are not worthy of the light, yet!")
			return false
		end
			item:transform(transformItem)
		return true
	end

	local lightOff = item:getId(29623)
	local randomValue = math.random(1, 4)
		if lightOff and randomValue == 1 then
			item:transform(29624)
		elseif lightOff and randomValue == 2 then
			item:transform(29625)
		elseif lightOff and randomValue == 3 then
			item:transform(29626)
		elseif lightOff and randomValue == 4 then
			item:transform(29627)
		return true
	end 
end
