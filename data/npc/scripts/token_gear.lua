local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local talkState, xmsg = {}, {}
 
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)       npcHandler:onCreatureSay(cid, type, msg) end
function onThink()
    if not npcHandler:isFocused(cid) then
            Npc():setDirection(DIRECTION_SOUTH)
        end
    npcHandler:onThink()
end
 
local items = {
--[[sorc/druid]]--
   ["yalahari mask"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 9778
   },
   ["yalahari armor"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 9776
   },
   ["yalahari legs"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 9777
   },
   ["soft boots"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 6132
   },
   --[[paladin]]--
   ["famous gladiator"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 9735
   },
   ["calopteryx cape"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 15489
   },
   ["grasshopper legs"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 15490
   },
   ["void boots"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 26133
   },
   --[[knight]]--
   ["rubber cap"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 23536
   },
   ["heat core"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 23538
   },
   ["alloy legs"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 23539
   },
   ["metal spats"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 23540
   },
   --[[templar]]--
   ["prismatic helmet"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 18403
   },
   ["prismatic armor"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 18404
   },
   ["prismatic legs"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 18405
   },
   ["prismatic boots"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 18406
   },
   ["prismatic shield"] = {
     payitems = {
       {id = 18423, count = 50},
     },
     rewarditem = 18410
   }
}
 
local function getItemsFromTable(itemtable)
     local text = ""
     for v = 1, #itemtable do
         count, info = itemtable[v].count, getItemInfo(itemtable[v].id)
         local ret = ", "
         if v == 1 then
             ret = ""
         elseif v == #itemtable then
             ret = " and "
         end
         text = text .. ret
         text = text .. (count > 1 and count or info.article).." "..(count > 1 and info.plural or info.name)
     end
     return text
end
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "Which vocation are you shopping for? Example: (sorcerer, druid, paladin, knight, or templar)"})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, text = "Sorcerers may wear {yalahari mask}, {yalahari armor}, {yalahari legs}, and {soft boots}."})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = "Druids may wear {yalahari mask}, {yalahari armor}, {yalahari legs}, and {soft boots}."})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins may wear {famous gladiator}, {calopteryx cape}, {grasshopper legs}, and {void boots}."})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = "Knights may wear {rubber cap}, {heat core}, {alloy legs}, and {metal spats}."})
keywordHandler:addKeyword({'templar'}, StdModule.say, {npcHandler = npcHandler, text = "Templars may wear {prismatic helmet}, {prismatic armor}, {prismatic legs}, {prismatic boots} and {prismatic shield}."})
 
function creatureSayCallback(cid, type, msg)
 
     if not npcHandler:isFocused(cid) then
         return false
     end
 
     local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
     if msgcontains(msg, "gear") then
         selfSay("You can exchange your major crystalline tokens for various pieces of gear. If you are unsure what I offer, please ask for {help}.", cid)
         talkState[talkUser] = 1
     elseif items[msg:lower()] and talkState[talkUser] == 1 then
         local x = items[msg:lower()]
         local info = getItemInfo(x.rewarditem)
         selfSay("Do you want to exchange "..getItemsFromTable(x.payitems).." for "..info.article.." "..info.name.."?", cid)
         talkState[talkUser] = 2
         xmsg[cid] = msg
     elseif msgcontains(msg, "yes") and items[xmsg[cid]:lower()] and talkState[talkUser] == 2 then
         local x, n = items[xmsg[cid]:lower()], 0
         for c = 1, #x.payitems do
             if getPlayerItemCount(cid, x.payitems[c].id) >= x.payitems[c].count then
                 n = n + 1
             end
         end
         if n == #x.payitems then
             for r = 1, #x.payitems do
                 doPlayerRemoveItem(cid, x.payitems[r].id, x.payitems[r].count)
             end
             doPlayerAddItem(cid, x.rewarditem, 1)
             selfSay("Great, here is your "..xmsg[cid]..".", cid)
         else
             selfSay("You don't have all items, you need "..getItemsFromTable(x.payitems)..".", cid)
         end  
         talkState[talkUser] = 0
         xmsg[cid] = ""
     end
     return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
