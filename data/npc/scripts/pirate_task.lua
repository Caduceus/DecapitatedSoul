-- Collecting items and monster quests by Limos
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()  npcHandler:onThink() end

local lastSound = 0
function onThink()
    if lastSound < os.time() then
        lastSound = (os.time() + 5)
        if math.random(100) < 20 then
            Npc():say("HELP! PLEASE!!", TALKTYPE_MONSTER_YELL)
        end
    end
    npcHandler:onThink()
end

npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. Are you up for a {quest}?")

local quests = {
   [1] = {
     items = {
       {id = 2239, count = 1} -- pirate boots
     },
     monsters = {
     },
     message = "Did you find my message in a bottle?",
     level = 80, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 1}
     },
     rewardexp = 10
   },
   [2] = {
     items = {
       {id = 5462, count = 1}, -- pirate boots
       {id = 6098, count = 1}, -- eye patch
       {id = 6095, count = 1}, -- pirate shirt
       {id = 6126, count = 1} -- peg leg
     },
     monsters = {
     },
     message = "Grrreat, we need..",
     level = 80, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 2}
     },
     rewardexp = 1000
   },
    [3] = {
     items = {
       {id = 9956, count = 1} -- magical torch
     },
     message = "find my magical torch, The pirates took it when they captured me. Use it to destroy all of the maps you can find.", 
     level = 80, -- minimum level for this quest
     rewarditems = {
       {id = 2160, count = 5}
     },
     rewardexp = 4000
   },
   [4] = {
	items = {
	{id = 6097, count = 1} -- hook
     },
	 monsters = {
       {name = "captain hook", count = 1, storage = 21923},
     },
     message = "kill..", 
     level = 80, -- minimum level for this mission
     rewarditems = {
       {id = 2160, count = 2},
       {id = 5810, count = 1}
     },
     rewardexp = 8000
		}
   }

local storage = 2239

local function getItemsMonstersFromTable(imtable)
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
     return text
end

function creatureSayCallback(cid, type, msg)
     if not npcHandler:isFocused(cid) then
         return false
     end

     local player = Player(cid)
     local x = quests[player:getStorageValue(storage)]

     if msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
         if player:getStorageValue(storage) == 1 then
             selfSay("will you do something, for me?!?!", cid)
             npcHandler.topic[cid] = 1
         elseif x then
             if player:getLevel() >= x.level then
                 selfSay("Did you "..(x.items and "get "..getItemsMonstersFromTable(x.items) or "kill "..getItemsMonstersFromTable(x.monsters)).."?", cid)
                 npcHandler.topic[cid] = 1
             else
                 selfSay("The quest I gave you is for level "..x.level..", come back later.", cid)
             end
         else
             selfSay("Go away! You faul land lover.", cid)
             npcHandler:releaseFocus(cid)
         end
     elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
         if player:getStorageValue(storage) == 1 then
             player:setStorageValue(storage, 2)
             local x = quests[player:getStorageValue(storage)]
             selfSay(x.message.." "..getItemsMonstersFromTable(x.items or x.monsters)..".", cid)
         elseif x then
             local imtable = x.items or x.monsters
             local amount = 0
             for it = 1, #imtable do
                 local check = x.items and player:getItemCount(imtable[it].id) or player:getStorageValue(imtable[it].storage)
                 if check >= imtable[it].count then
                     amount = amount + 1
                 end
             end
             if amount == #imtable then
                 if x.items then
                     for it = 1, #x.items do
                         player:removeItem(x.items[it].id, x.items[it].count)
                     end
                 end
                 if x.rewarditems then
                     for r = 1, #x.rewarditems do
                         player:addItem(x.rewarditems[r].id, x.rewarditems[r].count)
                     end
                     player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You received "..getItemsMonstersFromTable(x.rewarditems)..".")
                 end
                 if x.rewardexp then
                     player:addExperience(x.rewardexp)
                     player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You received "..x.rewardexp.." experience.")
                 end
                 player:setStorageValue(storage, player:getStorageValue(storage) + 1)
                 local x = quests[player:getStorageValue(storage)]
                 if x then
                     selfSay(x.message.." "..getItemsMonstersFromTable(x.items or x.monsters)..".", cid)
                 else
                     selfSay("Well done! You did a great job on all your quests.", cid)
                 end
             else
                 local n = 0
                 for i = 1, #imtable do
                     local check = x.items and player:getItemCount(imtable[i].id) or player:getStorageValue(imtable[i].storage)
                     if check < imtable[i].count then
                         n = n + 1
                     end
                 end
                 local text = ""
                 local c = 0
                 for v = 1, #imtable do
                     local check = x.items and player:getItemCount(imtable[v].id) or player:getStorageValue(imtable[v].storage)
                     if check < imtable[v].count then
                         c = c + 1
                         local ret = ", "
                         if c == 1 then
                             ret = ""
                         elseif c == n then
                             ret = " and "
                         end
                         text = text .. ret
                         if x.items then
                             local count, info = imtable[v].count - player:getItemCount(imtable[v].id), ItemType(imtable[v].id)
                             text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
                         else
                             local count = imtable[v].count - (player:getStorageValue(imtable[v].storage) + 1)
                             text = text .. count.." "..imtable[v].name
                         end
                     end
                 end
                 selfSay(x.items and "You don't have all items, you still need to get "..text.."." or "You didn't kill all monsters, you still need to kill "..text..".", cid)
             end
         end
         npcHandler.topic[cid] = 0
     elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
         selfSay("Quit wasting my time then.", cid)
         npcHandler.topic[cid] = 0
     end
     return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "farewell!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "you'll be sorry...")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())