local firstItems = {2120, 2132, 2175, 2461, 2649, 2643, 2382, 20624}

function onLogin(player)

	local function admin()
		sendChannelMessage(3, TALKTYPE_CHANNEL_R1, "Caduceus † 999 † [Dev]: Welcome to Decapitated Soul, " .. player:getName() .. "!")
	end
	
	if player:getLastLoginSaved() == 0 then
	
		if player:getVocation():getBase():getId() == 1 then
			player:setStorageValue(10009, 5)
		end
		if player:getVocation():getBase():getId() == 2 then
			player:setStorageValue(10009, 6)
		end
		for i = 1, #firstItems do
			player:addItem(firstItems[i], 1)
		end
		sendChannelMessage(3, TALKTYPE_CHANNEL_R1, "Welcome Our Newest Player: " .. player:getName() .. "")
		player:addItem(player:getSex() == 0 and 2651 or 2650, 1)
		player:addItem(3960, 1):addItem(2671, 10)
		player:openChannel(3)
		player:setDirection(DIRECTION_WEST)
		player:popupFYI("Welcome to Decapitated Soul, " .. player:getName() .. "! Basic info can be found in your READ ME item, equipt in your ring slot. If you have any questions, please use our World Chat. Enjoy your Free Blessing until level 80!")
		player:loadVipData()
		player:updateVipTime()
		player:setStorageValue(10000, 2696)
		player:setStorageValue(9999, player:getVipDays())
		player:save()
		addEvent(broadcastMessage, 15 * 1000, "Welcome Our Newest Player: " .. player:getName() .. "", MESSAGE_STATUS_CONSOLE_ORANGE)
		addEvent(admin, 60 * 1000)
	end
	return true
end
