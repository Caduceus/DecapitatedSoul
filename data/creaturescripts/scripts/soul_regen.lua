function onKill(player, target)
	if isMonster(target) == true then
		player:addSoul(1)
end
return true
end