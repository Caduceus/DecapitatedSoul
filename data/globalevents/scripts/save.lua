local config = {
	broadcast = {120, 30},
	delay = 120,
	events = 30
}

local function executeSave(seconds, iv)
	if(isInArray(config.broadcast, seconds)) then
		broadcastMessage("[Server]: Server maintenance in " .. seconds .. " seconds, please mind it may cause slight lag!", MESSAGE_STATUS_CONSOLE_BLUE)
	end

	if(seconds > 0) then
		addEvent(executeSave, config.events * 1000, seconds - config.events, iv)
	else
		saveServer()
		cleanMap()
		broadcastMessage("[Server]: Thank you for playing on Decapitated Soul! Next maintenance in 2 hours.", MESSAGE_STATUS_CONSOLE_BLUE)
	end
end

function onThink(interval)
	if(table.maxn(config.broadcast) == 0) then
		saveServer()
	else
		executeSave(config.delay, interval)
	end
	return true
end
