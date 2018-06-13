local config = {
    reqLevel = 100,
    storage = 15001,
    waitTime = 10,
    monsterSpawnPosition = Position(1232, 1103, 10),
    monsterName = "Stormblast",
    MonsterNameKnight = "rat",
    removeMonsterTime = 10 * 60,
    playerDestination = Position(1237, 1099, 10)
}

local nextTime = 0
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid == 1945 then
        if item.uid ~= 15102 then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_CANNOTUSETHISOBJECT))
            return true
        end

        if player:getLevel() < config.reqLevel then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Switch requires level ".. config.reqLevel ..".")
            return true
        end

        if player:getStorageValue(config.storage) == 1 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already completed the catacombs quest.")
            return true
        end

        if os.time() <= nextTime then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Sorry, you need to wait ".. os.time() - nextTime .." more seconds.")
            return true
        end
        if player:getVocation():getBase():getId() == 4 then
            local spawnMonster = Game.createMonster(config.monsterNameKnight, config.monsterSpawnPosition, false, true)
             if spawnMonster then
                         print('check..')
                addEvent(function(cid)
                    local monster = Monster(cid)
                    if monster then
                        monster:remove()
                    end
                end, config.removeMonsterTime * 1000, spawnMonster:getId())
            end
        else
            local spawnMonster = Game.createMonster(config.monsterName, config.monsterSpawnPosition, false, true)
            if spawnMonster then
                addEvent(function(cid)
                    local monster = Monster(cid)
                    if monster then
                        monster:remove()
                    end
                end, config.removeMonsterTime * 1000, spawnMonster:getId())
            end
        end
   
        player:teleportTo(config.playerDestination, false)
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Hope to see you on the other side!")
        nextTime = os.time() + config.waitTime
    end

    item:transform(item.itemid == 1945 and 1946 or 1945)
    return true
end 