local waterIds = {493, 4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 7236, 10499, 15401, 15402}
local lootTrash = {2234, 2238, 2376, 2509, 2667}
local lootCommon = {2152, 2167, 2168, 2669, 7588, 7589}
local lootRare = {2143, 2146, 2149, 7158, 7159}
local lootVeryRare = {7632, 7633, 10220}
local useWorms = true

-- Config for monster fishing
local config = {
    enabled = true, -- enable or disable monster fishing
    debug = false, -- enable debug messages in console
    verifyMonsters = false, -- disable this if you are having problems with Monster fishing::Warning - Invalid monster name
    chance = 100, -- chance to catch a monster in % - 50 means you have a 50/50 chance of getting a monster or a fish
    bossLevel = 300, -- min level to catch a "boss"
    bossSkill = 10, -- min fishing skill to catch a "boss"
    monsters = {
        -- [minLevel] = {"monster", "names", "for", "level"}
        [100] = {"Quara Hydromancer", "Quara Constrictor", "Quara Mantassin"},
        [150] = {"Quara Pincher", "Quara Predator"},
        [200] = {"Serpent Spawn", "Wyrm"},
        [300] = {"Sea Serpent"},
    },
    bosses = {
        -- Monsters that can only be caught with atleast "bossLevel" and "bossSkill"
        "Trigama",
    }
}

-- Validate monsters configuration
if config.verifyMonsters then
    local m = {}
    for minLevel, monsters in pairs(config.monsters) do
        m[minLevel] = {}
        if config.debug then print("#monsters", #monsters) end
        for i = 1, #monsters do
            if MonsterType(monsters[i]) then
                table.insert(m[minLevel], monsters[i])
            else
                print("Monster fishing::Warning - Invalid monster name:", monsters[i])
            end
        end
        if config.debug then print("Monster fishing::Debug - #monsters added", #m[minLevel]) end
    end
    config.monsters = m
end

function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    local targetId = itemEx.itemid
    if not isInArray(waterIds, itemEx.itemid) then
        return false
    end
    local pos = player:getPosition()
	if getTilePzInfo(pos) == true then 
		player:say('You cannot fish in a protection zone.', TALKTYPE_MONSTER_SAY)
	return false
    end

    if targetId == 10499 then
        local targetItem = Item(itemEx.uid)
        local owner = targetItem:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
        if owner ~= 0 and owner ~= player:getId() then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are not the owner.")
            return true
        end

        toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
        targetItem:remove()

        local rareChance = math.random(1, 100)
        if rareChance == 1 then
            player:addItem(lootVeryRare[math.random(#lootVeryRare)], 1)
        elseif rareChance <= 3 then
            player:addItem(lootRare[math.random(#lootRare)], 1)
        elseif rareChance <= 10 then
            player:addItem(lootCommon[math.random(#lootCommon)], 1)
        else
            player:addItem(lootTrash[math.random(#lootTrash)], 1)
        end
        return true
    end

    if targetId ~= 7236 then
        toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
    end

    if targetId == 493 or targetId == 15402 then
        return true
    end

    player:addSkillTries(SKILL_FISHING, 1)
    if math.random(1, 100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
        if useWorms and not player:removeItem("worm", 1) then
            return true
        end

        if targetId == 15401 then
            local targetItem = Item(itemEx.uid)
            targetItem:transform(targetId + 1)
            targetItem:decay()

            if math.random(1, 100) >= 97 then
                player:addItem(15405, 1)
                return true
            end
        elseif targetId == 7236 then
            local targetItem = Item(itemEx.uid)
            targetItem:transform(targetId + 1)
            targetItem:decay()

            local rareChance = math.random(1, 100)
            if rareChance == 10 then
                player:addItem(7158, 1)
                return true
            elseif rareChance <= 25 then
                player:addItem(2669, 1)
                return true
            elseif rareChance <= 50 then
                player:addItem(7159, 1)
                return true
            end
        end
        if config.enabled and math.random(100) <= config.chance then
            local level = player:getLevel()
            local skill = player:getSkillLevel(SKILL_FISHING)
            local tmpMonsters = {}

            for minLevel, monsters in pairs(config.monsters) do
                if config.debug then print("Monster fishing::Debug - Level check:", level, ">=", minLevel) end
                if level >= minLevel then
                    if config.debug then print("Monster fishing::Debug - Level check passed - #monsters:", #monsters) end
                    for i = 1, #monsters do
                        if config.debug then print("Monster fishing::Debug - Found monster:", monsters[i]) end
                        table.insert(tmpMonsters, monsters[i])
                    end
                end
            end

            if level >= config.bossLevel and skill >= config.bossSkill then
                for i = 1, #config.bosses do
                    table.insert(tmpMonsters, config.bosses[i])
                end
            end
            if config.debug then print("Monster fishing::Debug - #tmpMonsters: "..#tmpMonsters) end
            if #tmpMonsters > 0 then
                local pos = player:getPosition()
                Game.createMonster(tmpMonsters[math.random(1, #tmpMonsters)], pos)
                return true
            end
        end
        player:addItem("fish", 1)
    end
    return true
end
