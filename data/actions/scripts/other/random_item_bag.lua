-- Time Chest by Limos
local config = {
     exhausttime = 12*60*60, -- time
     exhauststorage = 2302,
     level = 25 -- minimum level to open the chest
}

local rewarditems = {
         [25] = {
             nextlevel = 50,
             {id = 3982, chance = 5, count = 1}, -- start with the lowest chances
             {id = 2476, chance = 10, count = 1},
             {id = 2479, chance = 15, count = 1},
             {id = 2148, chance = 70, count = math.random(1, 50)}
         },
         [50] = {
             nextlevel = 100,
             {id = 7730, chance = 5, count = 1},
             {id = 2466, chance = 10, count = 1},
             {id = 2497, chance = 15, count = 1},
             {id = 2152, chance = 70, count = math.random(1, 20)}
         },
         [100] = {
             nextlevel = 200,
             {id = 2492, chance = 5, count = 1},
             {id = 2498, chance = 10, count = 1},
             {id = 2195, chance = 15, count = 1},
             {id = 2152, chance = 70, count = math.random(20, 50)}
         },
         [200] = {
             nextlevel = 400,
             {id = 2472, chance = 5, count = 1},
             {id = 2470, chance = 10, count = 1},
             {id = 2157, chance = 15, count = 1},
             {id = 2160, chance = 70, count = math.random(1, 5)}
         },
         [400] = {
             nextlevel = 600,
             {id = 2472, chance = 5, count = 1},
             {id = 2470, chance = 10, count = 1},
             {id = 2157, chance = 15, count = 1},
             {id = 2160, chance = 70, count = math.random(1, 5)}
         }
     }
     function onUse(player, item, fromPosition, target, toPosition, isHotkey)
     if player:getLevel() < config.level then
         doSendMagicEffect(pos, CONST_ME_POFF)
         player:sendTextMessage(MESSAGE_STATUS_SMALL, "You need to be level "..config.level.." to open the box.")
         return true
     end

     if player:getStorageValue(config.exhauststorage) > os.time() then
         local time = player:getStorageValue(config.exhauststorage) - os.time()
         local hours, minutes, seconds = math.floor (time / 3600), math.floor ((time - ((math.floor (time / 3600)) * 3600))/ 60), time - ((math.floor (time/60)) * 60)
         if time >= 3600 then
             text = hours.." "..(hours == 1 and "hour" or "hours")..", "..minutes.." "..(minutes == 1 and "minute" or "minutes").." and "..seconds.." "..(seconds == 1 and "second" or "seconds")
         elseif time >= 60 then
             text = minutes.." "..(minutes == 1 and "minute" or "minutes").." and "..seconds.." "..(seconds == 1 and "second" or "seconds")
         else
             text = seconds.." "..(seconds == 1 and "second" or "seconds")
         end
         doSendMagicEffect(pos, CONST_ME_POFF)
         player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to wait "..text.." before you can get a reward again.")
         return true
     end

     local chance = math.random(1,100)
     for v, x in pairs(rewarditems) do
         if player:getLevel() >= v and player:getLevel() < x.nextlevel then
             level = v
         end
     end

     for i = 1, #rewarditems[level], 1 do
         if chance < rewarditems[level][i].chance then
             local info = getItemInfo(rewarditems[level][i].id)
             if rewarditems[level][i].count > 1 then
                 text = rewarditems[level][i].count .. " " .. info.plural
             else
                 text = info.article .. " " .. info.name
             end

             local reward = player:addItem(rewarditems[level][i].id, rewarditems[level][i].count)
                 text = "You have found " .. text .. "."
                 player:addItem(reward)
                 player:setStorageValue(config.exhauststorage, os.time() + 12*60*60)
				 player:sendTextMessage(MESSAGE_INFO_DESCR, text)
				 Item(item.uid):remove(1)
             return true
         else
             chance = chance - rewarditems[level][i].chance
         end
     end
end
