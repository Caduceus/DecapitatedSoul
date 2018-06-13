local minPlayers = 2
local maxPlayers = 10
local waitTime = 5

function onThink(interval)
local playerCount = Game.getPlayerCount()
	if Game.getPlayerCount() > 4 then
        setupZombieEvent(minPlayers, maxPlayers, waitTime)
    return true
	end
