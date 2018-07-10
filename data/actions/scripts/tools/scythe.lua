function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 2739 then
		target:transform(2737)
		target:decay()
		Game.createItem(2694, 1, toPosition)
		return true
	elseif target.itemid == 5466 then
		target:transform(5464)
		target:decay()
		Game.createItem(5467, 1, toPosition)
		return true
	end
	return destroyItem(player, target, toPosition)
end
