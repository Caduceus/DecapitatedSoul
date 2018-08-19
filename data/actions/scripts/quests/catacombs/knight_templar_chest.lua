local storage = 15001

local chests = {
	[15002] = {itemid = 7384, count = 1},
	[15003] = {itemid = 7392, count = 1},
	[15004] = {itemid = 7380, count = 1},
	--[15005] = {itemid = 7383, count = 1}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if chests[item.uid] then
		if player:getStorageValue(storage) == 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'It\'s empty.')
			return true
		end

		local chest = chests[item.uid]
		local itemType = ItemType(chest.itemid)
		local book = player:addItem(6103, 1)
		if itemType then
			local article = itemType:getArticle()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. '.')
		end
	if player:getVocation():getBase():getId() == 9 then
		local weapon = player:addItem(chest.itemid, chest.count)
		local tempWeapon = player:addItem(7383, 1)
			tempWeapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for completing the Catacombs on " .. os.date("%B %d, %Y") .. ".")
			weapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for completing the Catacombs on " .. os.date("%B %d, %Y") .. ".")
			player:addItem(24774, 1)
			book:setAttribute(ITEM_ATTRIBUTE_TEXT, "Congrats ".. player:getName() ..", on completion of the Catacombs Quest on " .. os.date("%B %d, %Y") .. "! Thank you for playing with us on Decapitated Soul!")
			player:setStorageValue(storage, 1)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Relic Sword is for healing only.')
		else
			weapon:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This weapon was awarded to ".. player:getName() ..", for completing the Catacombs on " .. os.date("%B %d, %Y") .. ".")
			player:addItem(24774, 1)
			book:setAttribute(ITEM_ATTRIBUTE_TEXT, "Congrats ".. player:getName() ..", on completion of the Catacombs Quest on " .. os.date("%B %d, %Y") .. "! Thank you for playing with us on Decapitated Soul!")
			player:setStorageValue(storage, 1)
		end
		return true
	end
end
