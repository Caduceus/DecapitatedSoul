-- Monster Tasks by Limos
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local xmsg = {}

function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid)  end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid)  end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()  npcHandler:onThink()  end

local storage = 62003
local exstorage = 62004 

local monsters = {
   ["Rotworms"] = {exstorage = 6010, storage = 5010, mstorage = 19000, amount = 50, rewardexp = 200, items = { {id = 2160, count = 1},{id = 18422, count = 1}}},
   ["Carrion Worms"] = {exstorage = 6011, storage = 5011, mstorage = 19001, amount = 50, rewardexp = 1000, items = { {id = 2160, count = 1},{id = 18422, count = 1}}},
   ["Amazons"] = {exstorage = 6012, storage = 5012, mstorage = 19002, amount = 50, rewardexp = 1000, items = { {id = 2160, count = 1},{id = 18422, count = 1}}},
   ["Cyclops"] = {exstorage = 6013, storage = 5013, mstorage = 19003, amount = 50, rewardexp = 1000, items = { {id = 2160, count = 1},{id = 18422, count = 1}}},
   ["Dragon Hatchlings"] = {exstorage = 6014, storage = 5014, mstorage = 19004, amount = 50, rewardexp = 1000, items = { {id = 2160, count = 1},{id = 18422, count = 1}}},
   ["Heroes"] = {exstorage = 6015, storage = 5015, mstorage = 19005, amount = 50, rewardexp = 1000, items = { {id = 2160, count = 1},{id = 18422, count = 1}}},
   ["Dragons"] = {exstorage = 6016, storage = 5016, mstorage = 19006, amount = 50, rewardexp = 5000, items = { {id = 2160, count = 3},{id = 18422, count = 1}}},
   ["Dragon Lords"] = {exstorage = 6017, storage = 5017, mstorage = 19007, amount = 50, rewardexp = 8000, items = { {id = 2160, count = 5},{id = 18422, count = 1}}},
   ["Vampires"] = {exstorage = 6029, storage = 5029, mstorage = 19019, amount = 50, rewardexp = 10000, items = { {id = 2160, count = 6},{id = 18422, count = 1}}},
   ["Demodras"] = {exstorage = 6018, storage = 5018, mstorage = 19008, amount = 50, rewardexp = 15000, items = { {id = 2160, count = 10},{id = 18422, count = 1}}},
   
}

local lastSound = 0
function onThink()
    if lastSound < os.time() then
        lastSound = (os.time() + 5)
        if math.random(100) < 20 then
            Npc():say("Looking for some extra tokens?!", TALKTYPE_MONSTER_SAY)
        end
    end
    npcHandler:onThink()
end

local function getItemsFromTable(itemtable)
     local text = ""
     for v = 1, #itemtable do
         count, info = itemtable[v].count, ItemType(itemtable[v].id)
         local ret = ", "
         if v == 1 then
             ret = ""
         elseif v == #itemtable then
             ret = " and "
         end
         text = text .. ret
         text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
     end
     return text
end

local function Cptl(f, r)
     return f:upper()..r:lower()
end

function creatureSayCallback(cid, type, msg)

     local player, cmsg = Player(cid), msg:gsub("(%a)([%w_']*)", Cptl)
     for k, x in pairs(monsters) do
     if player:getStorageValue(x.exstorage) ~= -1 and player:getStorageValue(x.exstorage) < os.time() then -- If the 24 hours have passed
         player:setStorageValue(x.storage, -1)
         player:setStorageValue(x.mstorage, -1)
         player:setStorageValue(x.exstorage, -1)
		 end
	 end
     if not npcHandler:isFocused(cid) then
         if msg == "hi" or msg == "hello" then
             npcHandler:addFocus(cid)
             if player:getStorageValue(storage) == -1 then
                 local text, n = "",  0
                 for k, x in pairs(monsters) do
                     if player:getStorageValue(x.mstorage) < x.amount then
                         n = n + 1
                         text = text .. ", "
                         text = text .. ""..x.amount.." {"..k.."}"
                     end
                 end
                 if n > 1 then
                     npcHandler:say("I have several tasks for you to kill monsters"..text..", which one do you choose? I can also show you a {list} with rewards and you can {stop} a task if you want.", cid)
                     npcHandler.topic[cid] = 1
                     xmsg[cid] = msg
                 elseif n == 1 then
                     npcHandler:say("I have one last task for you"..text..".", cid)
                     npcHandler.topic[cid] = 1
                 else
                     npcHandler:say("You have completed all tasks, I have nothing for you to do anymore, good job though.", cid)
                 end
             elseif player:getStorageValue(storage) == 1 then
                 for k, x in pairs(monsters) do
                     if player:getStorageValue(x.storage) == 1 then
                         npcHandler:say("Did you kill "..x.amount.." "..k.."?", cid)
                         npcHandler.topic[cid] = 2
                         xmsg[cid] = k
                     end
                 end
             end
         else
             return false
         end
     elseif monsters[cmsg] and npcHandler.topic[cid] == 1 then
         if player:getStorageValue(monsters[cmsg].storage) == -1 then
             npcHandler:say("Good luck, come back when you have killed "..monsters[cmsg].amount.." "..cmsg..".", cid)
             player:setStorageValue(storage, 1)
             player:setStorageValue(monsters[cmsg].storage, 1)
         else
             npcHandler:say("You already did the "..cmsg.." mission.", cid)
         end
         npcHandler.topic[cid] = 0
     elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 2 then
         local x = monsters[xmsg[cid]]
         if player:getStorageValue(x.mstorage) >= x.amount then
             npcHandler:say("Good job, here is your reward: Experience, "..getItemsFromTable(x.items)..".", cid)
             for g = 1, #x.items do
                 player:addItem(x.items[g].id, x.items[g].count)
             end
             player:addExperience(x.rewardexp)
             player:setStorageValue(x.storage, 2)
             player:setStorageValue(storage, -1)
             player:setStorageValue(x.exstorage, os.time() + 24*60*60)
             npcHandler.topic[cid] = 3
         else
             npcHandler:say("You didn't kill them all, you still need to kill "..x.amount -(player:getStorageValue(x.mstorage) + 1).." "..xmsg[cid]..".", cid)
         end
     elseif msgcontains(msg, "task") and npcHandler.topic[cid] == 3 then
         local text, n = "",  0
         for k, x in pairs(monsters) do
             if player:getStorageValue(x.mstorage) < x.amount then
                 n = n + 1
                 text = text .. (n == 1 and "" or ", ")
                 text = text .. "{"..k.."}"
             end
         end
         if text ~= "" then
             npcHandler:say("Want to do another task? You can choose "..text..".", cid)
             npcHandler.topic[cid] = 1
         else
             npcHandler:say("You have completed all tasks.", cid)
         end
     elseif msgcontains(msg, "no") and npcHandler.topic[cid] == 1 then
         npcHandler:say("Ok then.", cid)
         npcHandler.topic[cid] = 0
     elseif msgcontains(msg, "stop") then
         local text, n = "",  0
         for k, x in pairs(monsters) do
             if player:getStorageValue(x.mstorage) < x.amount then
                 n = n + 1
                 text = text .. (n == 1 and "" or ", ")
                 text = text .. "{"..k.."}"
                 if player:getStorageValue(x.storage) == 1 then
                      player:setStorageValue(x.storage, -1)
                 end
             end
         end
         if player:getStorageValue(storage) == 1 then
             npcHandler:say("Alright, let me know if you want to continue another task, you can still choose "..text..".", cid)
         else
             npcHandler:say("You have not started any new task yet, if you want to a start one, you can choose "..text..".", cid)
         end
         player:setStorageValue(storage, -1)
         npcHandler.topic[cid] = 1
     elseif msgcontains(msg, "list") then
         local text = "Tasks\n\n"
         for k, x in pairs(monsters) do
             if player:getStorageValue(x.mstorage) < x.amount then
                 text = text ..k .." ["..(player:getStorageValue(x.mstorage) + 1).."/"..x.amount.."]:\n  Rewards:\n  "..getItemsFromTable(x.items).."\n  "..x.rewardexp.." Experience \n\n"
             else
                 text = text .. k .." [DONE]\n"
             end
         end
         player:showTextDialog(1949, "" .. text)
         npcHandler:say("Here you are.", cid)
     elseif msgcontains(msg, "bye") then
         npcHandler:say("Bye.", cid)
         npcHandler:releaseFocus(cid)
     else
         npcHandler:say("What?", cid)
     end
     return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)