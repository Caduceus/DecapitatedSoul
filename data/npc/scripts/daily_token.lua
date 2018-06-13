local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)                               npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)                           npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)                       npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                                           npcHandler:onThink()                    end


local tokens = 18422 -- id of tokens
local items = {
	["1 vip day"] = {
        amount = 5,
        id = 10135
    },
    ["5 vip days"] = {
        amount = 10,
        id = 10134
    },
    ["10 vip days"] = {
        amount = 20,
        id = 10133
    },
    ["lottery ticket"] = {
        amount = 1,
        id = 5957
    },
    --[["tibiora box"] = {
        amount = 10,
        id = 11401
    },]]
    ["bless rune"] = {
        amount = 3,
        id = 2300
    },
    ["pirate backpack"] = {
        amount = 10,
        id = 5926
    },
    ["buggy backpack"] = {
        amount = 50,
        id = 15646
    },
    ["dragon backpack"] = {
        amount = 50,
        id = 11243
    },
    ["double xp grant"] = {
        amount = 25,
        id = 1948
    }
}

local itemToGive = {}

-- this will check the table if the index exists
function isInTable(table_t, value)
    if type(table_t) == "table" and value ~= nil then
        for index, v in pairs(table_t) do
            if index == value then
                return true
            end
        end
    end
    return false
end

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

    if isInTable(items, string.lower(msg)) then
		selfSay('Do you want to buy a {'..msg..'} for {'..items[string.lower(msg)].amount..' daily tokens}?', cid)
        itemToGive = items[string.lower(msg)]
        talkState[talkUser] = 1
    elseif msgcontains(msg, 'yes') and talkState[talkUser] == 1 then
        if doPlayerRemoveItem(cid, tokens, itemToGive.amount) then
            doPlayerAddItem(cid, itemToGive.id)                           
            selfSay("Well, I am sure shocked!", cid)
            talkState[talkUser] = 0
        else
			selfSay('Come back when you have {'..itemToGive.amount..' game tokens}! This is not a helping hands, you smuck, get outta here!', cid)
            talkState[talkUser] = 0
        end
    elseif msgcontains(msg, "no") and talkState[talkUser] == 1 then
        selfSay('Come back when you are not wasting my time.', cid)
        talkState[talkUser] = 0
    else
        --selfSay("Sorry, I don't sell "..msg, cid)
        selfSay('You know what else is hot? My foot in your ass! Do I look like I have {'..msg..'}. Get out of here, pig.', cid)
        talkState[talkUser] = 0
    end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())