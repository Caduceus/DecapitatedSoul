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
   ["1 vip day"] = {
     payitems = {
       {id = 18422, count = 5},
     },
     rewarditem = 10135
   },
   ["5 vip day"] = {
     payitems = {
       {id = 18422, count = 10},
     },
     rewarditem = 10134
   },
   ["10 vip day"] = {
     payitems = {
       {id = 18422, count = 20},
     },
     rewarditem = 10133
   },
   ["lottery ticket"] = {
     payitems = {
       {id = 18422, count = 1},
     },
     rewarditem = 5957
   },
   ["bless rune"] = {
     payitems = {
       {id = 18422, count = 3},
     },
     rewarditem = 2300
   },
   ["pirate backpack"] = {
     payitems = {
       {id = 18422, count = 10},
     },
     rewarditem = 5926
   },
   ["buggy backpack"] = {
     payitems = {
       {id = 18422, count = 50},
     },
     rewarditem = 15646
   },
   ["dragon backpack"] = {
     payitems = {
       {id = 18422, count = 50},
     },
     rewarditem = 11243
   },
   ["double xp grant"] = {
     payitems = {
       {id = 18422, count = 25},
     },
     rewarditem = 1948
   },
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
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "The items I offer are: {1 vip day}, {5 vip day}, {10 vip day}, {lottery ticket}, {bless rune}, {pirate backpack}, {buggy backpack}, {dragon backpack}, and {double xp grant}"})
 
function creatureSayCallback(cid, type, msg)
 
     if not npcHandler:isFocused(cid) then
         return false
     end
 
     local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
     if msgcontains(msg, "exchange") then
         selfSay("You can exchange your daily tokens for various items. If you are unsure what I offer, please ask for {help} or check the board to your right!", cid)
         talkState[talkUser] = 1
     elseif items[msg:lower()] and talkState[talkUser] == 1 then
         local x = items[msg:lower()]
         local info = getItemInfo(x.rewarditem)
         selfSay("Do you want to exchange "..getItemsFromTable(x.payitems).." for "..info.article.." {"..info.name.."}?", cid)
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
             selfSay("Come back when you have {"..getItemsFromTable(x.payitems).."}! This is not a charity, you smuck, get outta here!", cid)
         end  
         talkState[talkUser] = 1
         xmsg[cid] = ""
     end
     return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
