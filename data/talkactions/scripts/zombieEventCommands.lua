function onSay(player, words, param)
    local split = param:split(",")

    if split[1] == "join" then
        -- If it's a staff member, just teleport inside and do not count as a participant
        if player:getGroup():getAccess() then
            player:teleportTo(ze_WaitingRoomStartPosition)
            return false
        end

        -- If the state of the event is closed or started, stop them from join
        if isInArray({ze_EVENT_CLOSED, ze_EVENT_STARTED}, getZombieEventState()) then
            return false
        end

        -- If player got pz, forbid them to join
        if player:isPzLocked() then
            player:sendCancelMessage("You cannot join while your in a fight.")
            return false
        end
        
        -- If player has zombie event storage
        if player:getStorageValue(1000) == 1 then
        player:sendCancelMessage("You are already in the waiting room.")
            return false
        end

        -- If there is max players joined, stop them from join
        if getZombieEventJoinedCount() >= ze_maxPlayers then
            player:sendCancelMessage("The event is already full.")
            return false
        end

        -- Execute join event
        player:joinZombieEvent()
    elseif split[1] == "start" then
        -- If not staff member, they stop them from setup a event
        if not player:getGroup():getAccess() then
            return false
        end

        local minPlayers = tonumber(split[2])
        local maxPlayers = tonumber(split[3])
        local waitTime = tonumber(split[4])

        local failStart = false
        if minPlayers == nil or minPlayers < 1 then
            failStart = true
        elseif maxPlayers == nil or maxPlayers > Game.getPlayerCount() then
            failStart = true
        elseif waitTime == nil or waitTime < 1 then
            failStart = true
        end

        if failStart then
            player:sendCancelMessage("!zombie start, [minPlayers, maxPlayers, waitTime].")
            return false
        end

        -- Set the new variables and setup the event
        setupZombieEvent(minPlayers, maxPlayers, waitTime)
    end

    return false
end