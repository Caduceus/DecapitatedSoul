local testArena = {
	frompos = {x = 1097, y = 983, z = 10},
	topos = {x = 1131, y = 1005, z = 10},
	exitpos = {x = 1101, y = 995, z = 8}
}
local pvpArena = {
	frompos = {x = 1103, y = 1021, z = 14},
	topos = {x = 1111, y = 1029, z = 14},
	exitpos = {x = 1116, y = 1016, z = 14}
}

function onPrepareDeath(player, lastHitKiller, mostDamageKiller)
	if player:isPlayer() then
		local ppos = player:getPosition()
		local conditions = {CONDITION_POISON,CONDITION_FIRE,CONDITION_ENERGY,CONDITION_BLEEDING,CONDITION_FREEZING,CONDITION_PARALYZE,CONDITION_DRUNK,CONDITION_CURSED,CONDITION_DAZZLED,CONDITION_PACIFIED}
			for i = 1, #conditions do
				player:removeCondition(conditions[i])
			end
		if isInRange(ppos, testArena.frompos, testArena.topos) or isInRange(ppos, pvpArena.frompos, pvpArena.topos) then
			local maxhp = player:getMaxHealth()
			player:addHealth(maxhp)
			addEvent(doCreatureAddHealth, 50, player:getId(), maxhp)
			local maxmana = player:getMaxMana()
			player:addMana(maxmana)
			player:sendTextMessage(MESSAGE_STATUS_WARNING,"Good fight ".. player:getName() ..", better luck next time.")
		end
		if isInRange(ppos, pvpArena.frompos, pvpArena.topos) then
				player:teleportTo(pvpArena.exitpos)
				player:setDirection(DIRECTION_SOUTH)
			return true
		elseif isInRange(ppos, testArena.frompos, testArena.topos) then
				player:teleportTo(testArena.exitpos)
				player:setDirection(DIRECTION_EAST)
			return true
		end
	end
	return true
end

function onLogin(player)
	player:registerEvent("arena")
	return true
end

