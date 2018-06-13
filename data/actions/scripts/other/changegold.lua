local config = {
	[ITEM_GOLD_COIN] = {changeTo = ITEM_PLATINUM_COIN},
	[ITEM_PLATINUM_COIN] = {changeBack = ITEM_GOLD_COIN, changeTo = ITEM_CRYSTAL_COIN},
	[ITEM_CRYSTAL_COIN] = {changeBack = ITEM_PLATINUM_COIN, changeTo = ITEM_GOLD_BAR},
	[ITEM_GOLD_BAR] = {changeBack = ITEM_CRYSTAL_COIN, changeTo = ITEM_SCARAB_COIN},
	[ITEM_SCARAB_COIN] = {changeBack = ITEM_GOLD_BAR}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local coin = config[item:getId()]
	if coin.changeTo and item.type == 100 then
		item:remove()
		player:addItem(coin.changeTo, 1)
	elseif coin.changeBack then
		item:remove(1)
		player:addItem(coin.changeBack, 100)
	else
		return false
	end
	return true
end
