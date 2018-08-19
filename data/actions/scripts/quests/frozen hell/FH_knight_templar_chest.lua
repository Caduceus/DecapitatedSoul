local storage = 15009

local chests = {
	[15006] = {itemid = 12649, count = 1},
	[15007] = {itemid = 7422, count = 1},
	[15008] = {itemid = 7434, count = 1},
	--[15009] = {itemid = 8932, count = 1}
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
		if player:getVocation():getBase():getId() == 9 then
			local weapon = player:addItem(chest.itemid, chest.count)
			local tempWeapon = player:addItem(8932, 1)
			tempWeapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for the completion of Frozen Hell on " .. os.date("%B %d, %Y") .. ".")
			weapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for the completion of Frozen Hell on " .. os.date("%B %d, %Y") .. ".")
			player:setStorageValue(storage, 1)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'The Calamity is for healing only.')
		else
			weapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for the completion of Frozen Hell on " .. os.date("%B %d, %Y") .. ".")
			player:setStorageValue(storage, 1)
		end
		return true
	end
end
