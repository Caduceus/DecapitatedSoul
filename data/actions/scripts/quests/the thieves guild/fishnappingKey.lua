function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid ~= 12505 then
		return false
	end

	if player:getStorageValue(Storage.thievesGuild.Mission06) == 2 then
		player:removeItem(8762, 1)
		player:say('In your haste you break the key while slipping in.', TALKTYPE_MONSTER_SAY)
		player:teleportTo(Position(854, 1278, 7))
	end
	return true
end