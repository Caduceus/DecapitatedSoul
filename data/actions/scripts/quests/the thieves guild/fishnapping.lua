function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.thievesGuild.Mission06) == 2 and player:getItemCount(2684) > 1 then
		player:removeItem(2684, 1)
		player:addItem(8766, 1)
		player:say('To buy some time you replace the fish with a piece of carrot.', TALKTYPE_MONSTER_SAY)
		player:setStorageValue(Storage.thievesGuild.Mission06, 3)
	end
	return true
end
