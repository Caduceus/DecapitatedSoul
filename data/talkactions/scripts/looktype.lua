function onSay(player, words, param)
     if not player:getGroup():getAccess() then
         return true
     end
     
     if player:getOutfit().lookMount > 0 then
		player:sendCancelMessage("this player is currently mounted.")
		 return false
	 end
	 
	 --[[if player:isMounted() then
		 return false
	 end]]
     
     local t = param:split(",")
     local lookType = tonumber(t[1])
     if not lookType then
         lookType = MonsterType(t[1]) and MonsterType(t[1]):getOutfit().lookType
         if not lookType then
             player:sendCancelMessage("A monster with that name does not exist.")
             return false
         end
     end
     if t[2] then
         playerx, player = player, Player(t[2]:gsub("^%s*(.-)%s*$", "%1"))
         if not player then
             playerx:sendCancelMessage("A player with that name does not exist or is not online.")
             return false
         end
     end
     if lookType >= 0 and lookType ~= 1 and lookType ~= 135 and lookType ~= 411 and lookType ~= 415 and lookType ~= 424 and (lookType <= 160 or lookType >= 192) and lookType ~= 439 and lookType ~= 440 and lookType ~= 468 and lookType ~= 469 and (lookType < 474 or lookType > 485) and lookType ~= 501 and lookType ~= 518 and lookType ~= 519 and lookType ~= 520 and lookType ~= 524 and lookType ~= 525 and lookType ~= 536 and lookType ~= 543 and lookType ~= 549 and lookType ~= 576 and lookType ~= 581 and lookType ~= 582 and lookType <= 595 then
         local playerOutfit = player:getOutfit()
         playerOutfit.lookType = lookType
         player:setOutfit(playerOutfit)
     else
         player = playerx or player
         player:sendCancelMessage("A look type with that id does not exist.")
     end
     return false
	end