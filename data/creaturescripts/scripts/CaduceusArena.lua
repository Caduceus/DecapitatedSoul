local arena = {
	frompos = {x = 1097, y = 983, z = 10},
	topos = {x = 1131, y = 1005, z = 10},
	exitpos = {x = 1099, y = 994, z = 9}
}

function onPrepareDeath(player, lastHitKiller, mostDamageKiller)
	if player:isPlayer() then
		local ppos = player:getPosition()
		if isInRange(ppos, arena.frompos, arena.topos) then
			local maxhp = player:getMaxHealth()
			player:addHealth(maxhp)
			addEvent(doCreatureAddHealth, 100, player:getId(), maxhp)
			local maxmana = player:getMaxMana()
			player:addMana(maxmana)
			player:sendTextMessage(MESSAGE_STATUS_WARNING,"Good fight, maybe next time.")
		end
		if isInRange(ppos, arena.frompos, arena.topos) then
			player:teleportTo(arena.exitpos)
			return true
		end
	end
	return true
end

function onLogin(player)
	player:registerEvent("CaduceusArena")
	return true
end