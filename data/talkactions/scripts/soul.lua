function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if not player:getAccountId() == 1 then
		return false
	end
	
	local targetPlayer = Player(param)
	if targetPlayer == nil then
			player:sendCancelMessage('Usage: ' .. words .. ' <playername>')
			return true
		end	
    
	local total = targetPlayer:getSoul()
	local max = targetPlayer:getMaxSoul()
	local action = string.sub(words, 2, #words) .. 'ed'
 
   if words == '/removesoul' then
        targetPlayer:addSoul(-total)
        player:sendCancelMessage('You have removed ' .. total .. ' soul from ' .. targetPlayer:getName() .. '.')
    elseif words == '/addsoul' then
        targetPlayer:addSoul(max)
        player:sendCancelMessage('You have added ' .. max .. ' soul to ' .. targetPlayer:getName() .. '.')
    end
end
