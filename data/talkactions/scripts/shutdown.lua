local function shutdownServer()
    Game.setGameState(GAME_STATE_SHUTDOWN)
end
 
local function shutdownMessage(timeLeft)
    if timeLeft == 1 then
        broadcastMessage("Server will shutdown in 1 minute. Please make your way to a safe logout location.", MESSAGE_STATUS_WARNING)
 
        addEvent(shutdownServer, 1 * 60 * 1000)
        return
    end
 
    broadcastMessage("Server will shutdown in ".. timeLeft .." minutes. Please make your way to a safe logout location.", MESSAGE_STATUS_WARNING)
    shutdownEvent = addEvent(shutdownMessage, 1 * 60 * 1000, timeLeft - 1)
 
end
 
local SHUTDOWN_STATE = false
function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end
    
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
 
    if param == "kill" then
        os.exit()
        return false
    end
 
    if SHUTDOWN_STATE then
        if param == "cancel" or param == "stop" then
            broadcastMessage("Shutdown event has been stopped. Sorry for the inconvenience.", MESSAGE_STATUS_WARNING)
            SHUTDOWN_STATE = false
            stopEvent(shutdownEvent)
        else    
            player:sendCancelMessage("Server is already in a shutdown state. To cancel shutdown use the \"/shutdown stop\" command.")
        end
     
        return false
    end
 
    local number = tonumber(param)
    if not number then
        player:sendCancelMessage("Numeric param may not be lower than 0.")
        return false
    end
 
    if number == 0 then
        shutdownServer()
        return false
    end  
 
    shutdownMessage(number)
    SHUTDOWN_STATE = true
    return false
end
