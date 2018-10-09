-- Collecting items and monster missions by Limos (Modified by Xagul to support both monsters and items in the same task)

-- HYDRA>demodras>WARLOCK/infernalist>DEMON>LOST SOUL/DARK TORTURE>ORSHABAAL
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()  npcHandler:onThink() end

npcHandler:setMessage(MESSAGE_GREET, "If it isn't the great |PLAYERNAME|, looking for another round of {quests} are you?")

local missions = {
   [1] = {
     items = {
       {id = 11199, count = 40}, --hydra head
       {id = 7250, count = 40} -- hydra tongues
     },
    monsters = {
       {name = "Hydra", count = 100, storage = 21908}
     },
     message = "For your first stop, you will to make your way through the lush lands of Queimada.",
     level = 100, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 5}
     },
     rewardexp = 65000
   },
   [2] = {
     items = {
       {id = 21401, count = 50} -- dragon tear
     },
    monsters = {
       {name = "Demodras", count = 100, storage = 21909}
     },
     message = "Ok, next you will have to pass beyond the dragons of Drogheda to...",
     level = 110, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 10}
     },
     rewardexp = 70000
   },
   [3] = {
     items = {
       {id = 12410, count = 20}, -- luminous orb
       {id = 5904, count = 20} -- magic sulphur
     },
    monsters = {
       {name = "warlock", count = 100, storage = 21910},
       {name = "infernalist", count = 50, storage = 21911},
       {name = "fury", count = 50, storage = 21912}
     },
    message = "Within the Queimada forests, you will find a circle of casting. Use this to..",
     level = 120, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 15}
     },
     rewardexp = 75000
   },
   [4] = {
     items = {
       {id = 11233, count = 40}, -- unholy bones
       {id = 5480, count = 5} -- -- cat's paw
     },
    monsters = {
       {name = "lost soul", count = 100, storage = 21914},
       {name = "dark torturer", count = 40, storage = 21915}
     },
     message = "The figures from the past stand tall within Purgatory Isle.",
     level = 140, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 25}
     },
     rewardexp = 85000
   },
   [5] = {
     items = {
       {id = 5906, count = 40}, -- demon dust
       {id = 5954, count = 40}, -- demon horn
       {id = 2151, count = 40} -- talon
     },
    monsters = {
       {name = "demon", count = 100, storage = 21913}
     },
     message = "Time to face your fears. Infernal punishments must pursue.",
     level = 130, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 20},
       {id = 2386, count = 1}
     },
     rewardexp = 80000
   },
   [6] = {
     items = {
       {id = 10564, count = 20} -- mangled hand
     },
    monsters = {
       {name = "orshabaal", count = 50, storage = 21916}
     },
     message = "Like the Bermuda Triangle, she swallows her victims whole.",
     level = 150, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 30}
     },
     rewardexp = 90000
   },
   [7] = {
     items = {
       {id = 5893, count = 20} -- juggernaut tooth
     },
    monsters = {
       {name = "juggernaut", count = 50, storage = 21917}
     },
     message = "I Have Suffered For Your Sins, But Now Is When The Fun Begins.",
     level = 160, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 35}
     },
     rewardexp = 95000
   },
   [8] = {
     items = {
       {id = 11335, count = 20}, -- broken halberd
       {id = 11367, count = 20} -- undead heart
     },
    monsters = {
       {name = "ghastly dragon", count = 50, storage = 21918}
     },
     message = "We venture now to Alexandria, a land of rebellion.",
     level = 175, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 40}
     },
     rewardexp = 100000
   },
   [9] = {
     items = {
       {id = 10578, count = 20} -- frosty heart
     },
    monsters = {
       {name = "frost dragon", count = 50, storage = 21919}
     },
     message = "Your time has come. Venture deep into the Frozen Wastes.",
     level = 225, -- minimum level for this mission
     rewarditems = {
       {id = 15515, count = 1}
     },
     rewardexp = 110000
   },
    [10] = {
    items = {
     },
    monsters = {
       {name = "soul reaper", count = 20, storage = 21920},
       {name = "angel of death", count = 1, storage = 21921}
     },
     message = "Your soul is now attuned with the evil at hand. Time to face your greatest fears. Make your way deep into the Frozen Wastes. The labyrinth awaits!",
     level = 250, -- minimum level for this mission
     rewarditems = {
       {id = 15515, count = 10}
     },
     rewardexp = 500000
   }
}

local storage = 45556

local function getItemsMonstersFromTable(imtable, imtype)
     local text = ""
     for v = 1, #imtable do
         local ret = ", "
         if v == 1 then
             ret = ""
         elseif v == #imtable then
             ret = " and "
         end
         text = text .. ret
         count = imtable[v].count
         if imtable[v].id then
             info = ItemType(imtable[v].id)
             text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
         else
             text = text .. count .." "..imtable[v].name
         end
     end

    if(text ~= "") then
        text = ((imtype == "monsters" and "Kill: ") or "Collect: ") .. text
    end
     return text
end

function creatureSayCallback(cid, type, msg)
     if not npcHandler:isFocused(cid) then
         return false
     end

     local player = Player(cid)
     local x = missions[player:getStorageValue(storage)]

     if msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
         if player:getStorageValue(storage) == -1 then
             selfSay("Are you sure you are ready for these? They may be too hard for you!", cid)
             npcHandler.topic[cid] = 1
         elseif x then
             if player:getLevel() >= x.level then
                local missionstr = ""
              if(x.monsters) then
                   missionstr = getItemsMonstersFromTable(x.monsters, "monsters")
                end
                if(x.items) then
                   missionstr = missionstr .. ((missionstr ~= "" and "\n") or "") .. getItemsMonstersFromTable(x.items, "items")
                end
                 selfSay("Did you complete my task?\n".. missionstr, cid)
                 npcHandler.topic[cid] = 1
             else
                 selfSay("The mission I gave you is for level "..x.level..", come back later.", cid)
             end
         else
             selfSay("Go away.. I'm done with you!", cid)
             npcHandler:releaseFocus(cid)
         end
     elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
         if player:getStorageValue(storage) == -1 then
             player:setStorageValue(storage, 1)
             local x = missions[player:getStorageValue(storage)]
        
            local missionstr = ""
            if(x.monsters) then
                missionstr = getItemsMonstersFromTable(x.monsters, "monsters")
            end
            if(x.items) then
                missionstr = missionstr .. ((missionstr ~= "" and "\n") or "") .. getItemsMonstersFromTable(x.items, "items")
            end
             selfSay(x.message.."\n".. missionstr ..".", cid)
         elseif x then
             local imtable = x.items or x.monsters
             local amount = 0
        
            local failed = false
            local failstr = ""
            -- Check Monsters
            for i, monster in ipairs(x.monsters) do
                local mstorage = player:getStorageValue(monster.storage)
                if(mstorage < 0) then
                   mstorage = 0
                end
          
                if(#x.monsters > 1 and i == #x.monsters) then
                    failstr = failstr .." and "
                elseif(i ~= 1) then
                    failstr = failstr ..", "
                else
                    failstr = "I think you may want to check that questlog again.\nYou have killed: "
                end
                failstr = failstr .. mstorage .."/".. monster.count .." ".. monster.name
          
               if(mstorage < monster.count) then
                    failed = true
                end
            end
        
            -- Check Items
            for i, item in ipairs(x.items) do
                local icount = player:getItemCount(item.id)          
          
                if(#x.items > 1 and i == #x.items) then
                    failstr = failstr .." and "
                elseif(i ~= 1) then
                    failstr = failstr ..", "
                elseif(failstr == "") then
                    failstr = "Umm, nooo.. Try again.. \nYou have collected: "
                else
                    failstr = failstr .."\nYou have collected: "
                end
          
                local itemInfo = ItemType(item.id)
                failstr = failstr .. ((icount > item.count and item.count) or icount) .."/".. (item.count > 1 and item.count or itemInfo:getArticle()).." "..(item.count > 1 and itemInfo:getPluralName() or itemInfo:getName())
          
                if(icount < item.count) then
                    failed = true
               end
            end
        
            if(failed) then
               selfSay(failstr, cid)
            else
               if x.items then
                     for it = 1, #x.items do
                         player:removeItem(x.items[it].id, x.items[it].count)
                     end
                 end
                 if x.rewarditems then
                     for r = 1, #x.rewarditems do
                         player:addItem(x.rewarditems[r].id, x.rewarditems[r].count)
                     end
                     player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "You received "..getItemsMonstersFromTable(x.rewarditems)..".")
                 end
                 if x.rewardexp then
                     player:addExperience(x.rewardexp)
                     player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "You received "..x.rewardexp.." experience.")
                 end
                 player:setStorageValue(storage, player:getStorageValue(storage) + 1)
                 local x = missions[player:getStorageValue(storage)]
                 if x then                
                    local missionstr = ""
                      if(x.monsters) then
                        missionstr = getItemsMonstersFromTable(x.monsters, "monsters")
                    end
                    if(x.items) then
                        missionstr = missionstr .. ((missionstr ~= "" and "\n") or "") .. getItemsMonstersFromTable(x.items, "items")
                    end
                     selfSay(x.message.."\n".. missionstr ..".", cid)
                 else
					 Game.broadcastMessage("Congratulations to ".. player:getName() .." for completing all of Lilith's questline.")
                     selfSay("Congratulations on your completion of my quest chain. I have brought you through Hell and back. Thank you for taking the time to take the adventures presented to you! ~ Caduceus", cid)

                 end
            end
         end
         npcHandler.topic[cid] = 0
     elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
         selfSay("Whatever.", cid)
         npcHandler.topic[cid] = 0
     end
     return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Bye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, have a nice day!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
