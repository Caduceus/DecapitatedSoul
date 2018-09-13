function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:say('puff puff', TALKTYPE_MONSTER_SAY)
	item:getPosition():sendMagicEffect(CONST_ME_PURPLESMOKE)
	item:getPosition():sendMagicEffect(CONST_ME_BLACKSMOKE)
	return true
end