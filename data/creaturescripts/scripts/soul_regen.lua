function onKill(player, target)
	if isInArray({"rotworm","rat","cave rat","dog","cat","chicken"}, target:getName():lower()) then
	return false
end
	if target:isMonster() == true then
		player:addSoul(1)
	end
	return true
end
