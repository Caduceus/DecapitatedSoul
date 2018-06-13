function onStepIn(creature, item, position, fromPosition)

    local player = creature:getPlayer()

    if not player == nil then
        return true
    end

    -- If it's a staff memeber, just teleport inside and do not count as participant
    if player:getGroup():getAccess() then
        player:teleportTo(ze_WaitingRoomStartPosition)
        return true
    end

    -- If the event state is closed or started, then stop players from enter
    if isInArray({ze_EVENT_CLOSED, ze_EVENT_STARTED}, getZombieEventState()) then
        player:teleportTo(fromPosition, true)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    -- Check if the event has already max players
    if getZombieEventJoinedCount() >= ze_maxPlayers then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "The Zombie Event is already full.")
        player:teleportTo(fromPosition, true)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    -- Execute join event
    player:joinZombieEvent()
    return true
end