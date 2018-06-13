local rewards = {
    [1738] = {
        [{8, 50}] = {
            {id = 3982, chance = 5, count = 1}, -- start with the lowest chances
            {id = 2476, chance = 10, count = 1},
            {id = 2479, chance = 15, count = 1},
            {id = 2148, chance = 70, count = {10, 50}}
        },
        [{50, 100}] = {
            {id = 7730, chance = 5, count = 1},
            {id = 2466, chance = 10, count = 1},
            {id = 2497, chance = 15, count = 1},
            {id = 2152, chance = 70, count = {1, 20}}
        },
        [{100, 200}] = {
            {id = 2472, chance = 5, count = 1},
            {id = 2496, chance = 10, count = 1},
            {id = 2520, chance = 15, count = 1},
            {id = 2160, chance = 70, count = {20, 50}}
        }
    },
    [1739] = {
        [{25, 50}] = {
            {id = 3982, chance = 5, count = 1}, -- start with the lowest chances
            {id = 2476, chance = 10, count = 1},
            {id = 2479, chance = 15, count = 1},
            {id = 2148, chance = 70, count = {10, 50}}
        },
        [{50, 100}] = {
            {id = 7730, chance = 5, count = 1},
            {id = 2466, chance = 10, count = 1},
            {id = 2497, chance = 15, count = 1},
            {id = 2152, chance = 70, count = {1, 20}}
        },
        [{100, 800}] = {
            {id = 2472, chance = 5, count = 1},
            {id = 2496, chance = 10, count = 1},
            {id = 2520, chance = 15, count = 1},
            {id = 2160, chance = 70, count = {20, 50}}
        }
    }
}
 
local function getRewardsByLevel(tmp, lv)
    for k, v in pairs(tmp) do
        if (lv >= k[1] and lv <= k[2]) then
            return v
        end
    end
    return false
end
 
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local tmp = rewards[item:getId()]
 
    if item:getName() == 'Opened Loot Box' then
        return false
    end
 
    if not tmp then
        return true
    end
 
    local rew = getRewardsByLevel(tmp, player:getLevel())
 
    if not rew then
        return true
    end
 
    for k, v in ipairs(rew) do
        if math.random(100) <= v.chance then
            item:addItem(v.id, type(v.count) == 'number' and v.count or math.random(v.count[1], v.count[2]))
        end
    end
 
    player:say('Opened Loot Box', TALKTYPE_MONSTER_SAY)
    item:setAttribute('name', 'Opened Loot Box')
    player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
    return true
end