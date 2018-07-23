local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local talkState, xmsg = {}, {}
 
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)       npcHandler:onCreatureSay(cid, type, msg) end
function onThink()
    if not npcHandler:isFocused(cid) then
            Npc():setDirection(DIRECTION_EAST)
        end
    npcHandler:onThink()
end
 
local items = {
   ["medusa skull"] = {
     payitems = {
       {id = 11226, count = 20},
     },
     rewarditem = 16105
   },
   ["upgrade"] = {
     payitems = {
       {id = 11226, count = 40},
       {id = 16105, count = 1},
     },
     rewarditem = 16106
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
 
function creatureSayCallback(cid, type, msg)
 
     if not npcHandler:isFocused(cid) then
         return false
     end
 
     local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
     if msgcontains(msg, "trinket") then
         selfSay("You can turn in your medusa hair for a {medusa skull} or {upgrade} your current trinket.", cid)
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