-- Collecting items and monster missions by Limos (Modified by Xagul to support both monsters and items in the same task)

-- HYDRA>demodras>WARLOCK/infernalist>DEMON>LOST SOUL/DARK TORTURE>ORSHABAAL
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()  npcHandler:onThink() end

npcHandler:setMessage(MESSAGE_GREET, "Tally ho |PLAYERNAME|, looking for my plushies? Well I got a {job} for you!")

local missions = {
   [1] = {
     items = {
       {id = 11199, count = 40}, --hydra head
       {id =  7250, count = 40}  --hydra tongues
     },
    monsters = {
       {name = "Hydra", count = 200, storage =19025}
     },
     message = "For your first plushie you must go to the lush land of Quimada and hunt hydra.",
     level = 100, -- minimum level for this mission
     rewarditems = {
       {id = 35317, count = 1}
     },
     
   },
   [2] = {
    items = {
     },
    monsters = {
       {name = "Demon", count = 200, storage = 19026},
      },
     message = "Want my second plushie head to Purgatory Isle and hunt demons!",
     level = 100, -- minimum level for this mission
     rewarditems = {
       {id = 35844, count = 1}
     },
   }
}

-- will haVE TO EDIT THIS TO GIVE PACKAGES, VIA WRAP 
local storage = 45561 

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

     if msgcontains(msg, 'job') or msgcontains(msg, 'quest') then
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
                    failstr = "smh. ~rolls eyes~ \nYou have killed: "
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
