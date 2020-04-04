local invalidLook = {
	1, 135, 411, 415 
}

function onSay(player, words, param)
     if not player:getGroup():getAccess() then
         return true
     end
     
     if player:getOutfit().lookMount > 0 then
		player:sendCancelMessage("this player is currently mounted.")
		 return false
	 end
	 	 
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
         if not player or player:getAccountId() == 1 then
             playerx:sendCancelMessage("A player with that name does not exist or is not online.")
             return false
         end
     end
    if lookType >= 0 and lookType ~= 1 
		and lookType ~= 135
		and lookType ~= 411
		and lookType ~= 415 
		and lookType ~= 424 
		and (lookType <= 160 or lookType >= 192)
		and lookType ~= 439 
		and lookType ~= 440 
		and lookType ~= 468 
		and lookType ~= 469 
		and (lookType < 474 or lookType > 485) 
		and lookType ~= 501 
		and lookType ~= 518 
		and lookType ~= 519 
		and lookType ~= 520 
		and lookType ~= 524 
		and lookType ~= 525 
		and lookType ~= 536 
		and lookType ~= 543 
		and lookType ~= 549 
		and lookType ~= 576 
		and lookType ~= 581 
		and lookType ~= 582 
		and lookType ~= 597 
		and lookType ~= 616 
		and lookType ~= 623 
		and lookType ~= 625
		and (lookType < 638 or lookType > 643)
		and lookType ~= 645
		and lookType ~= 646
		and (lookType < 652 or lookType > 663) 
		and lookType ~= 678
		and (lookType < 700 or lookType > 711)
		and lookType ~= 713
		and lookType ~= 715
		and lookType ~= 718
		and lookType ~= 719
		and lookType ~= 722
		and lookType ~= 723
		and lookType ~= 737
		and (lookType < 741 or lookType > 744)
		and lookType ~= 748
		and (lookType < 751 or lookType > 758)
		and (lookType < 764 or lookType > 841)
		and lookType ~= 861
		and (lookType < 864 or lookType > 867)
		and lookType ~= 871
		and lookType ~= 872
		and lookType ~= 888
		and (lookType < 891 or lookType > 898)
		and lookType ~= 912
		and lookType ~= 930
		and lookType ~= 941
		and lookType ~= 942
		and lookType ~= 946
		and lookType ~= 953
		and lookType ~= 954
		and (lookType < 995 or lookType > 1010)
		and lookType ~= 1012
		and lookType ~= 1014
		and lookType ~= 1015
		and lookType ~= 1016
		and lookType ~= 1022
		and lookType ~= 1074
		and lookType ~= 1075
		and (lookType < 1080 or lookType > 1087)
		and lookType ~= 1089
		and lookType ~= 1090
		and (lookType < 1096 or lookType > 1100)
		and lookType ~= 1108
		and lookType ~= 1145
		and (lookType < 1153 or lookType > 1156)
		and lookType ~= 1160
		and lookType ~= 1170
		and lookType ~= 1171		
		and lookType ~= 1172
		and lookType ~= 1176
		and lookType ~= 1177
		and lookType ~= 1178
		and lookType ~= 1182
		and lookType ~= 1192
		and lookType ~= 1193
		and lookType ~= 1194
		and lookType ~= 1198
		and lookType ~= 1215
		and lookType ~= 1216
		and (lookType < 1225 or lookType > 1228)
		and (lookType < 1235 or lookType > 1242)
		and lookType ~= 1250
		and lookType ~= 1254
		and lookType ~= 1263
		and lookType ~= 1267
		and lookType ~= 1273
		and lookType ~= 1274
		and (lookType < 1287 or lookType > 1291)
		and lookType <= 1293 then
		
		
    local playerOutfit = player:getOutfit()
        playerOutfit.lookType = lookType
        player:setOutfit(playerOutfit)
        player:sendCancelMessage("Your look type was set to " .. lookType ..".")
    else
        player = playerx or player
        player:sendCancelMessage("A look type with that id does not exist.")
    end
    return false
end