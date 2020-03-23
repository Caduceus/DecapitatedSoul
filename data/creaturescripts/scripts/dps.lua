DPS_STORAGE = 50393
DPS_SERVER_RECORD = 50394
PLAYER_DPS = {}
PLAYER_EVENTS = {}

function ReadDPS(pid, cid)
    local player = Player(pid)
    local target = Monster(cid)
    if player and target then
        PLAYER_DPS[pid] = PLAYER_DPS[pid] * 1
        if PLAYER_DPS[pid] > player:getServerRecord(DPS_SERVER_RECORD) and player:getGuid() ~= 1 then
			player:setStorageValue(DPS_STORAGE, PLAYER_DPS[pid])
            player:setServerRecord(DPS_SERVER_RECORD, PLAYER_DPS[pid])
            player:save()
            target:say(string.format("New Server Record! DPS: %d", PLAYER_DPS[pid]), TALKTYPE_MONSTER_SAY, false, player, target:getPosition())
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "New Server Record! DPS: ".. PLAYER_DPS[pid] .."")
            sendChannelMessage(3, TALKTYPE_CHANNEL_R1, "New Server Record: Set by [" .. player:getName() .. "] with ".. PLAYER_DPS[pid] .." DPS!")
        end
        if PLAYER_DPS[pid] > player:getStorageValue(DPS_STORAGE) then
            player:setStorageValue(DPS_STORAGE, PLAYER_DPS[pid])
            target:say(string.format("New Personal Record! DPS: %d", PLAYER_DPS[pid]), TALKTYPE_MONSTER_SAY, false, player, target:getPosition())
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "New Personal Record! DPS: ".. PLAYER_DPS[pid] .."")
            player:save()
        else
            target:say(string.format("DPS: %d", PLAYER_DPS[pid]), TALKTYPE_MONSTER_SAY, false, player, target:getPosition())
        end
        PLAYER_DPS[pid] = 0
        PLAYER_EVENTS[pid] = nil
    end
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature then return primaryDamage, primaryType, secondaryDamage, secondaryType end
    if not attacker then return primaryDamage, primaryType, secondaryDamage, secondaryType end

    if creature:isMonster() and attacker:isPlayer() then
        if creature:getName() == "Training Dummy" then
            local damage = primaryDamage + secondaryDamage
            local pid = attacker:getId()
            if not PLAYER_DPS[pid] then PLAYER_DPS[pid] = 0 end
            PLAYER_DPS[pid] = PLAYER_DPS[pid] + damage
            if not PLAYER_EVENTS[pid] then
                PLAYER_EVENTS[pid] = addEvent(ReadDPS, 1000, pid, creature:getId())
            end
        end
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
