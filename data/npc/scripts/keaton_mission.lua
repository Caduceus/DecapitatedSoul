-- Collecting items and monster missions by Limos

-- HYDRA>demodras>WARLOCK/infernalist>DEMON>LOST SOUL/DARK TORTURE>ORSHABAAL
-- Collecting items and monster missions by Limos (Modified by Xagul to support both monsters and items in the same task)
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()  npcHandler:onThink() end

npcHandler:setMessage(MESSAGE_GREET, "Ohh young |PLAYERNAME|, I am sure happy to see you! Care to {help} me kill some of these rotworms? I am sort of chained up here.")

local missions = {
	[1] = {
     items = {
       {id = 13757, count = 10} -- coal
     },
    monsters = {
       {name = "rotworm", count = 20, storage = 21922},
     },
     message = "Grab me some lumps of coal for my basin, since you're already killing these beasts.", 
     level = 10, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 2},
       {id = 1988, count = 1}
     },
     rewardexp = 800
   }
 }
   
local storage = 45557

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

     if msgcontains(msg, 'help') or msgcontains(msg, 'kill') then
         if player:getStorageValue(storage) == -1 then
             selfSay("Great. Are you sure it is no trouble? I would hate to slow you.", cid)
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
                 selfSay("Did you complete my quest?\n".. missionstr, cid)
                 npcHandler.topic[cid] = 1
             else
                 selfSay("The mission I gave you is for level "..x.level..", come back later.", cid)
             end
         else
             selfSay("I recommend you go speak with {Damon}. He is having some of the same issues as me.", cid)
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
                    failstr = "Sorry, you are still missing some things...\nYou have killed: "
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
                    failstr = "Sorry, you are still missing some things...\nYou have collected: "
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
                     selfSay("Thank you!", cid)
                 end
            end
         end
         npcHandler.topic[cid] = 0
     elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
         selfSay("Oh well, I guess not then.", cid)
         npcHandler.topic[cid] = 0
     end
     return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Bye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, have a nice day!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())