function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

		if player:getItemCount(6500) > 0 then
			player:teleportTo(Position(807, 667, 7))
			player:removeItem(6500, 10)
		else
			player:teleportTo(fromPosition)
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You must sacrifice 10 demonic essences to enter!")
			doAreaCombatHealth(player, COMBAT_FIREDAMAGE, fromPosition, 0, -3000, -4000, CONST_ME_HITBYFIRE)
		end

	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end