local storage = 2215

local chests = {
	[15013] = {itemid = 2494, count = 1},
	[15014] = {itemid = 8890, count = 1},
	[15015] = {itemid = 7431, count = 1},
	[15016] = {itemid = 13166, count = 1}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if chests[item.uid] then
		if player:getStorageValue(storage) == 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'It\'s empty.')
			return true
		end

		local chest = chests[item.uid]
		local itemType = ItemType(chest.itemid)
		if itemType then
			local article = itemType:getArticle()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. '.')
		end

		player:addItem(chest.itemid, chest.count)
		player:setStorageValue(storage, 1)
	end

	return true
end
