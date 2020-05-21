function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local t = param:split(",")
	local effectType = tonumber(t[1])
     if not effectType then
        return false
    end
         
    if effectType >= 0 
		and (effectType <= 78 or effectType >= 157)
		and (effectType <= 159 or effectType >= 166)
		and effectType ~= 174
		and effectType ~= 183
		and (effectType <= 187 or effectType >= 190)
		and effectType ~= 192
		and effectType <= 206 then
	
	
		player:getPosition():sendMagicEffect(tonumber(param))
	else
		player:sendCancelMessage("An effect with that number does not exist.")
	end
	return false
end
