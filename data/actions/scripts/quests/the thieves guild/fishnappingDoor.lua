function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.thievesGuild.Mission06) == 3 then
		player:say('You slip through the door', TALKTYPE_MONSTER_SAY)
		player:teleportTo(Position(854, 1276, 7))
		player:setStorageValue(Storage.thievesGuild.Mission06, 4)
	end
	return true
end
