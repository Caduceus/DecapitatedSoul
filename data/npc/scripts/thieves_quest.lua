local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local Topic = {}
 
function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid)  end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid)  end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()  npcHandler:onThink()  end
 
--[[function thinkCallback(cid)
    local random = math.random(250)
    if random == 1 then
        npcHandler:say("Sir, Ma'am, have a gold coin to spare?")
    elseif random == 2 then
        npcHandler:say("I need help! Please help me!")
    elseif random == 3 then
        npcHandler:say("Alms! Alms for the poor!")
    end
    return true
end]]--
 
function creatureSayCallback(cid, type, msg)
	if(npcHandler.focus ~= cid) then
        return true
    end
	local player = Player(cid)
    if (msgcontains(msg, "hello") or msgcontains(msg, "hi")) and (not npcHandler:isFocused(cid)) then
        npcHandler:say("Hello " .. getCreatureName(cid) .. ". I am a poor man. Please help me.", cid)
        Topic[cid] = 0
        npcHandler:addFocus(cid)
    elseif(not npcHandler:isFocused(cid)) then
        return true
    elseif Topic[cid] == 1 then
        if msgcontains(msg, "yes") then
            if doPlayerRemoveMoney(cid, 100) == TRUE then
                npcHandler:say("Thank you very much. Can you spare 500 more gold pieces for me? I will give you a nice hint.", cid)
                Topic[cid] = 2
            else
                npcHandler:say("You haven't got enough money for me.", cid)
                Topic[cid] = 0
            end
        else
            npcHandler:say("Hmm, maybe next time.", cid)
            Topic[cid] = 0
        end
    elseif Topic[cid] == 2 then
        if msgcontains(msg, "yes") then
            if doPlayerRemoveMoney(cid, 500) == TRUE then
                npcHandler:say("That's great! I have stolen something from Dermot. You can buy it for 200 gold. Do you want to buy it?", cid)
                Topic[cid] = 3
            else
                npcHandler:say("Sorry, that's not enough.", cid)
                Topic[cid] = 0
            end
        else
            npcHandler:say("It was your decision.", cid)
            Topic[cid] = 0
        end
    elseif Topic[cid] == 3 then
        if msgcontains(msg, "yes") then
            if doPlayerRemoveMoney(cid, 200) == TRUE then
                npcHandler:say("Now you own the hot key.", cid)
                local key = doCreateItemEx(2092, 1)
                doItemSetAttribute(key, "aid", 2092)
                doPlayerAddItemEx(cid, key, 1)
            else
                npcHandler:say("Pah! I said 200 gold. You don't have so much.", cid)
            end
        else
            npcHandler:say("Ok. No problem. I'll find another buyer.", cid)
        end
        Topic[cid] = 0
    elseif msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
        npcHandler:say("Have a nice day.", cid, TRUE)
        Topic[cid] = 0
        npcHandler:releaseFocus(cid)
    elseif msgcontains(msg, "help") then
        npcHandler:say("I need gold. Can you spare 100 gold pieces for me?", cid)
        Topic[talkUser] = 1
    end
    return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())