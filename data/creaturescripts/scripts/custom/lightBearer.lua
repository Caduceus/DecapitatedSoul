function onThink(creature)
	if creature:getStorageValue(Storage.lightBearerComplete) >= 1 then
		return false
	elseif creature:getStorageValue(Storage.lightBearer) == 100 then
	local trophy = creature:addItem(10542, 1) 
        creature:setStorageValue(Storage.lightBearerComplete, 1)
        trophy:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "" ..creature:getName().. " helped to keep the fire basins burning and is one of the lightbearers of " .. os.date("%Y") .. "!")
        creature:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Congrats on becoming a lightbearer, ' .. creature:getName() .. '!')
    end
    return true
end
