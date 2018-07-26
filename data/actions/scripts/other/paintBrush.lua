function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local painting = math.random(1, 10)
if item.itemid == 16016 and target.itemid == 16017 then
		item:transform(16019)
		player:removeItem(16016, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have added paint to your brush.")
	return true
	elseif item.itemid == 16019 and target.itemid == 16022 then
		item:transform(16016)
		player:removeItem(16019, 1)
			if painting >= 5 and painting < 7 then
				target:transform(16024)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a masterpiece!")
				elseif painting == 1 then
					target:transform(16026)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a less than stellar painting!")
				elseif painting == 10 then
					target:transform(16030)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a less than stellar painting!")
			else
				target:transform(16028)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a painting!")
			end
	elseif item.itemid == 16019 and target.itemid == 16023 then
		item:transform(16016)
		player:removeItem(16019, 1)
			if painting >= 5 and painting < 7 then
				target:transform(16025)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a masterpiece!")
				elseif painting == 1 then
					target:transform(16027)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a less than stellar painting!")
				elseif painting == 10 then
					target:transform(16031)
					player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a less than stellar painting!")
			else
				target:transform(16029)
				player:sendTextMessage(MESSAGE_INFO_DESCR, "You have created a painting!")
			end
	elseif item.itemid == 16016 and target.itemid == 16022 or target.itemid == 16023 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You have to apply paint to your brush first.")
	return true
	end
end
