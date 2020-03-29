local minTargets = 1
local thunderstorm = 28001 -- Storage used for thunderstorm cooldown
local duration = 60000 -- 60 Lasts seconds
local ticks = 5000 -- Hits every 5 seconds

function shuffle(t)
    local rand = math.random
    assert(t, "table.shuffle() expected a table, got nil")
    local iterations = #t
    local j
  
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end
                  
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_YELLOWENERGY)

-- For exhaust on the first cast
local exhaust = Condition(CONDITION_EXHAUST)
exhaust:setParameter(CONDITION_PARAM_TICKS, 2000)

function thunderStormDuration(playeruid, count)
    -- Convert back to Player object
    local player = Player(playeruid)
    if player then -- If player still logged in
        local playerPos = player:getPosition()
        playerPos:sendMagicEffect(CONST_ME_YELLOWENERGY)
        local playerTile = Tile(Position(playerPos))
        if playerTile:hasFlag(TILESTATE_PROTECTIONZONE) == false and playerTile:hasFlag(TILESTATE_HOUSE) == false then -- if player not in PZ
            local targets = Game.getSpectators(playerPos, false, false, 6, 6, 5, 5)
            -- Shuffle targets table
            if targets then
                if #targets > 1 then
                    shuffle(targets)
                end
            end
            -- Strike targets
            local validTargets = {}
            local level = player:getLevel()
            local maglevel = player:getMagicLevel()
            local targetCount = minTargets + math.floor(maglevel / 20) -- Get extra target every 20 magic levels
            for k,v in pairs(targets) do
                -- Only target monsters
                if v:isMonster() then
                    local monsterPos = v:getPosition()
                    if monsterPos:isSightClear(playerPos) then
                        local currentTargets = #validTargets or 0
                        if currentTargets < targetCount then
                            table.insert(validTargets, v)
                        end
                    end
                end
            end
            if validTargets then
                for i = 1,#validTargets do
                    -- Animation
                    local monsterPos = validTargets[i]:getPosition()
                    monsterPos:sendMagicEffect(CONST_ME_BIGCLOUDS)
                    monsterPos.y = monsterPos.y - 1
                    monsterPos:sendMagicEffect(CONST_ME_BIGCLOUDS)
                    monsterPos.y = monsterPos.y + 2
                    monsterPos:sendMagicEffect(CONST_ME_BIGCLOUDS)
                    monsterPos.x = monsterPos.x - 1
                    monsterPos.y = monsterPos.y - 1
                    monsterPos:sendMagicEffect(CONST_ME_BIGCLOUDS)
                    monsterPos.x = monsterPos.x + 2
                    monsterPos:sendMagicEffect(CONST_ME_BIGCLOUDS)
                    -- Damage Formula
                    local min = (level / 5) + (maglevel * 1.4) + 15
                    local max = (level / 2) + (maglevel * 2.0) + 35
                    combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)  
                    combat:execute(player, Variant(validTargets[i].uid)) -- Strike Monster
                end
            end
        end
        -- Repeat until count reaches 0
        local counter = count - 1
        if counter > 0 then
            addEvent(thunderStormDuration, ticks, playeruid, counter)
        else
            player:setStorageValue(thunderstorm, -1)
        end
    else
        return false
    end
end

function onCastSpell(creature, var, isHotkey)
    local thunderstormExhaust = creature:getStorageValue(thunderstorm)
    if creature:getCondition(CONDITION_EXHAUST) then
        creature:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    if thunderstormExhaust ~= -1 then
        if thunderstormExhaust > os.time() then
            creature:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        end
    end
    creature:setStorageValue(thunderstorm, os.time() + duration)
    creature:addCondition(exhaust) -- Only exhaust on original cast
    addEvent(thunderStormDuration, 0, creature.uid, math.floor(duration / ticks))
    return true
end
