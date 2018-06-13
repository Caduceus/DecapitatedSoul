local arena = {
	frompos = {x = 1103, y = 1021, z = 14},
	topos = {x = 1111, y = 1029, z = 14},
	exitpos = {x = 1116, y = 1016, z = 14}
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
			player:sendTextMessage(MESSAGE_STATUS_WARNING,"[Arena]: You lost the duel.")
		end
		if isInRange(ppos, arena.frompos, arena.topos) then
			player:teleportTo(arena.exitpos)
			return true
		end
	end
	return true
end

function onLogin(player)
	player:registerEvent("pvparena")
	return true
end