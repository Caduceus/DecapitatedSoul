function onKill(player, target)
	if isInArray({"rotworm","rat","cave rat","dog","cat","chicken","sheep","rabbit","deer","squirrel","rabbit","snake","scorpion","poison spider","larva","slug","spider","bug","bear"}, target:getName():lower()) then
	return false
end
	if target:isMonster() == true then
		player:addSoul(1)
	end
	return true
end
