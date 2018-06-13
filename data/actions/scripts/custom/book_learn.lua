function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
    player = Player(cid)
    if not Player(player) then
        return false
    end
    local actions = {
    [6001] = {action = "discover", storages = {37101, 37103}},
    [6002] = {action = "skill", skills = {SKILL_SWORD, SKILL_MAGLEVEL}, levels = {1, 2}},
    [6003] = {action = "quest", storages = {10005, 10006}, values = {1, 3}},
    [6004] = {action = "spell", spells = {"Test Spell 1", "Test Spell 2"}}
    }
    if item.actionid > 6000 and item.actionid < 7000 then
        if actions[item.actionid]["action"] == "discover" then
            local discover = false
            for i = 1, #actions[item.actionid] do
                if player:getStorageValue(actions[item.actionid]["storages"][i]) ~= 1 then
                    player:setStorageValue(actions[item.actionid]["storages"][i], 1)
                    discover = true
                end
            end
            if discover then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You have discovered new locations to travel to!")
            else
                player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You have already discovered all the locations this source has to offer.")
            end
        elseif actions[item.actionid]["action"] == "skill" then
            if player:getStorageValue(item.actionid) ~= 1 then
                for i = 1, #actions[item.actionid]["skills"] do
                    skill = actions[item.actionid]["skills"][i]
                    if isInArray({SKILL_FIST, SKILL_CLUB, SKILL_SWORD, SKILL_AXE, SKILL_DISTANCE, SKILL_SHIELD, SKILL_FISHING}, skill) then
                        for j = 1, actions[item.actionid]["levels"][i] do
                            local xp = math.ceil(player:getVocation():getRequiredSkillTries(skill, player:getSkillLevel(skill) + 1))
                            player:addSkillTries(skill, xp)
                        end   
                    elseif skill == SKILL_MAGLEVEL then
                        for k = 1, actions[item.actionid]["levels"][i] do
                           
                            local xp = math.ceil(player:getVocation():getRequiredManaSpent(player:getBaseMagicLevel() + 1))
                            player:addManaSpent(xp)
                        end
                    end
                end
                player:setStorageValue(item.actionid, 1)
            else
                player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You didn't learn anything useful.")
            end
        elseif actions[item.actionid]["action"] == "quest" then
            local hadQuest = true
            for i = 1, #actions[item.actionid]["storages"] do
                if player:getStorageValue(actions[item.actionid]["storages"][i]) < actions[item.actionid]["values"][i] then
                    player:setStorageValue(actions[item.actionid]["storages"][i], actions[item.actionid]["values"][i])
                    hadQuest = false
                end
            end
            if hadQuest then
                player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You already discovered all the quests this source has to offer.")
            end
        elseif actions[item.actionid]["action"] == "spell" then
            for i = 1, #actions[item.actionid]["spells"] do
                if not player:hasLearnedSpell(actions[item.actionid]["spells"][i]) then
                    if player:canLearnSpell(actions[item.actionid]["spells"][i]) then
                        player:learnSpell(actions[item.actionid]["spells"][i])
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have learned the spell: " .. actions[item.actionid]["spells"][i] .. ".")
                    else
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "You cannot learn the spell: " .. actions[item.actionid]["spells"][i] .. ".")
                    end
                else
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already learned the spell: " .. actions[item.actionid]["spells"][i] .. ".")
                end
            end
        end
    end
   
    return true
end