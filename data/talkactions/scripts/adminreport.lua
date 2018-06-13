-- <talkaction words="!report" separator=" " script="adminreport.lua"/>
-- Coded by Dark ShaoOz, modified by Znote
function onSay(cid, words, param, channel)
	local player = Player(cid)
	local storage = 6708 -- You can change the storage if its already in use
	local delaytime = 120 -- Exhaust In Seconds.
	if param == '' then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Description required.")
		return false
	end
	if player:getStorageValue(storage) <= os.time() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your report has been successfully sent to Caduceus for review.")
		db.query("INSERT INTO `player_reports` (`id` ,`name` ,`account_id` ,`posx` ,`posy` ,`posz` ,`report_description` ,`date`)VALUES (NULL ,  " .. db.escapeString(player:getName()) .. ",  " .. db.escapeString(player:getAccountId()) .. ",  '" .. player:getPosition().x .. "',  '" .. player:getPosition().y .. "',  '" .. player:getPosition().z .. "',  " .. db.escapeString(param) .. ",  '" .. os.time() .. "')")
		player:setStorageValue(storage, os.time() + delaytime)
	else
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You have to wait " .. player:getStorageValue(storage) - os.time() .. " seconds before you can report again.")
	end
	return false
end
