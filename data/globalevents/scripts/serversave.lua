local shutdownAtServerSave = true
local cleanMapAtServerSave = false

local function serverSave()
	if shutdownAtServerSave then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	else
		Game.setGameState(GAME_STATE_CLOSED)

		if cleanMapAtServerSave then
			cleanMap()
		end

		Game.setGameState(GAME_STATE_NORMAL)
	end
end

local function secondServerSaveWarning()
	broadcastMessage("Server will be performing the daily restart in 1 minute. Please be prepared for shutdown.", MESSAGE_STATUS_WARNING)
	broadcastMessage("Server will be performing the daily restart in 1 minute. Please be prepared for shutdown.", MESSAGE_STATUS_CONSOLE_RED)
	addEvent(serverSave, 60000)
end

local function firstServerSaveWarning()
	broadcastMessage("Server will be performing the daily restart in 3 minutes. Please be prepared for shutdown.", MESSAGE_STATUS_WARNING)
	addEvent(secondServerSaveWarning, 120000)
end

function onTime(interval)
	broadcastMessage("Server will be performing the daily restart in 5 minutes. Please be prepared for shutdown.", MESSAGE_STATUS_WARNING)
	Game.setGameState(GAME_STATE_STARTUP)
	addEvent(firstServerSaveWarning, 120000)
	return not shutdownAtServerSave
end
