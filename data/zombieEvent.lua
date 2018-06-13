-- Store player kills
if zombieKillCount == nil then
    zombieKillCount = {}
end
 
-- Zombie Variables
ze_zombieName = "Zombie Event" -- Zombie name
ze_timeToStartInvasion = 5 -- When should the first zombie be summoned [seconds]
ze_zombieSpawnInerval = 1 -- The interval of each zombie that will get summoned
ze_zombieMaxSpawn = 70 -- Max zombies in the arena
ze_zombieCountGlobalStorage = 100 -- Use empty global storage
 
-- Player Variables
ze_joinStorage = 1000 -- Storage that will be added, when player join
ze_minPlayers = 1 -- Minimum players that have to join
ze_maxPlayers = 10 -- Maxnimum players that can join
ze_joinCountGlobalStorage = 101 -- Use empty global storage
 
-- States
ze_stateGlobalStorage = 102 -- Use empty global storage
ze_EVENT_CLOSED = 0
ze_EVENT_STATE_STARTUP = 1
ze_EVENT_STARTED = 2
 
-- Waiting room
ze_WaitingRoomStartPosition = Position(156, 2900, 7) -- Where should player be teleport in waiting room
ze_waitingRoomCenterPosition = Position(155, 2898, 7) -- Center of the waiting room
ze_waitingRoomRadiusX = 15 -- Depends how big the arena room is 25sqm to x
ze_waitingRoomRadiusY = 15 -- Depends how big the arena room is 25sqm to y
 
-- Zombie arena
ze_zombieArenaStartPosition = Position(186, 2892, 6) -- When event start where should player be teleported in the zombie arena?
ze_arenaCenterPosition = Position(207, 2893, 7) -- Center position of the arena
ze_arenaFromPosition = Position(180, 2872, 6) -- Pos of top left corner
ze_arenaToPosition = Position(229, 2914, 7) -- Pos of bottom right corner
ze_arenaRoomRadiusX = 25 -- Depends how big the arena room is 50sqm to x
ze_arenaRoomRadiusY = 25 -- Depends how big the arena room is 50sqm to y
ze_arenaRoomMultifloor = true -- Does the arena have more floors than one?
 
-- Other variables
ze_waitTime = 10 -- How long until the event begin?
ze_createTeleportPosition = Position(1086, 995, 8) -- Where should the teleport be created?
ze_teleportActionId = 7000 -- Actionid of the teleport
ze_trophiesTable = {
    [1] = {itemid = 7369, description = "Won First Place on Zombie Event."},
    [2] = {itemid = 7370, description = "Won Second Place on Zombie Event."},
    [3] = {itemid = 7371, description = "Won Third Place on Zombie Event."}
}
 
-- Get methods
function getZombieEventZombieCount()
    return Game.getStorageValue(ze_zombieCountGlobalStorage)
end
 
function getZombieEventJoinedCount()
    return Game.getStorageValue(ze_joinCountGlobalStorage)
end
 
function setZombieEventState(value)
    Game.setStorageValue(ze_stateGlobalStorage, value)
end
 
function getZombieEventState()
    return Game.getStorageValue(ze_stateGlobalStorage) or ze_EVENT_CLOSED
end
 
function resetZombieEvent()
    -- Reset variables
    Game.setStorageValue(ze_zombieCountGlobalStorage, 0)
    Game.setStorageValue(ze_joinCountGlobalStorage, 0)
    setZombieEventState(ze_EVENT_CLOSED)
 
    -- Clear the arena from zombies
    local spectator = Game.getSpectators(ze_arenaCenterPosition, ze_arenaRoomMultifloor, false, 0, ze_arenaRoomRadiusX, 0, ze_arenaRoomRadiusY)
    for i = 1, #spectator do
        if spectator[i]:isMonster() then
            spectator[i]:remove()
        end
    end
end
 
function startZombieEvent()
    local spectator = Game.getSpectators(ze_waitingRoomCenterPosition, ze_arenaRoomMultifloor, false, 0, ze_waitingRoomRadiusX, 0, ze_waitingRoomRadiusY)
    if getZombieEventJoinedCount() < ze_minPlayers then
        for i = 1, #spectator do
            spectator[i]:teleportTo(spectator[i]:getTown():getTemplePosition())
            spectator[i]:setStorageValue(ze_joinStorage, 0)
        end
 
        resetZombieEvent()
        Game.broadcastMessage("Zombie event failed to start, due to not enough participants.")
    else
        for i = 1, #spectator do
            spectator[i]:teleportTo(ze_zombieArenaStartPosition)
            spectator[i]:registerEvent("ZombiePlayerDeath")
        end
 
        Game.broadcastMessage("Zombie Event has started, good luck to all participants.")
        setZombieEventState(ze_EVENT_STARTED)
        addEvent(startZombieInvasion, ze_timeToStartInvasion * 1000)
    end
 
    -- Remove Teleport
    local item = Tile(ze_createTeleportPosition):getItemById(1387)
    if item:isTeleport() then
        item:remove()
    end
end
 
function startZombieInvasion()
    if getZombieEventState() == ze_EVENT_STARTED then
        local random = math.random
        local zombie = Game.createMonster(ze_zombieName, Position(random(ze_arenaFromPosition.x, ze_arenaToPosition.x), random(ze_arenaFromPosition.y, ze_arenaToPosition.y), random(ze_arenaFromPosition.z, ze_arenaToPosition.z)))
        if zombie then
            Game.setStorageValue(ze_zombieCountGlobalStorage, getZombieEventZombieCount() + 1)
        end
 
        addEvent(startZombieInvasion, ze_zombieSpawnInerval * 1000)
    end
end
 
function Player.joinZombieEvent(self)
    -- Set storage and teleport
    self:teleportTo(ze_WaitingRoomStartPosition)
    ze_WaitingRoomStartPosition:sendMagicEffect(CONST_ME_TELEPORT)
    self:setStorageValue(ze_joinStorage, 1)
 
    -- Add count and broadcast
    local count = getZombieEventJoinedCount()
    Game.setStorageValue(ze_joinCountGlobalStorage, count + 1)
    Game.broadcastMessage(string.format("%s has joined the Zombie Event! [%d/%d].", self:getName(), count + 1, ze_maxPlayers))
end
 
function setupZombieEvent(minPlayers, maxPlayers, waitTime)
    -- Event is not closed, then stop from start new one
    if getZombieEventState() ~= ze_EVENT_CLOSED then
        return
    end
 
    -- Create teleport and set the respective action id
    local item = Game.createItem(1387, 1, ze_createTeleportPosition)
    if item:isTeleport() then
        item:setAttribute(ITEM_ATTRIBUTE_ACTIONID, ze_teleportActionId)
    end
 
    -- Change the variables, to the new ones
    ze_minPlayers = minPlayers
    ze_maxPlayers = maxPlayers
    ze_waitTime = waitTime
 
    -- Set the counts, state, broadcast and delay the start of the event.
    Game.setStorageValue(ze_zombieCountGlobalStorage, 0)
    Game.setStorageValue(ze_joinCountGlobalStorage, 0)
    setZombieEventState(ze_EVENT_STATE_STARTUP)
    Game.broadcastMessage(string.format("The Zombie Event will start in %d minutes. The event requires atleast %d players and max %d players. Join by using !zombie join.", waitTime, minPlayers, maxPlayers))
    addEvent(startZombieEvent, waitTime * 60 * 1000)
end