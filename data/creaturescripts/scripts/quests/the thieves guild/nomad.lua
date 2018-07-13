function onKill(creature, target)
	local targetMonster = target:getName():lower() == 'nomad'
	if not targetMonster then
		return true
	end

	if target:isPlayer() or not targetMonster or target:getMaster() then
         return true
     end

	local player = creature:getPlayer()
	if player:getStorageValue(Storage.thievesGuild.Mission04) == 3 then
		player:setStorageValue(Storage.thievesGuild.Mission04, 4)
	end

	return true
end
