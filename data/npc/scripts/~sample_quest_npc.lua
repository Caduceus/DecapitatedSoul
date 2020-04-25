local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
local destination = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

--[[
    words = What the player says to the NPC
    reply = What the NPC says back.
    setStorage = If you want the NPC to set a storage to the player once he replies.
    setStorageNum = What to want to set the storage value to. eg: 1
    reqStorage = The NPC wont respond to the message unless that player has this storage set to a specific number
    reqStorageNum = The specific number of the required storage. eg: 4.
    items = You can add this to give a player items if they have the correct storage.
    exp = amount of exp given to the player.
]]--

local messages = {
    [1] = {
        words = {"quest", "mission", "adventure", "task"}, --If the player says any of these to the NPC
        reqStorage = 30000, --The NPC checks this storage
        reqStorageNum = nil, -- If the reqStorage is == nil (or doesn't exist) 
        reply = "Yes |PLAYERNAME|, I have a quest for you. Go kill the rats in my basement.", --The NPC will reply with this
        setStorage = 30000, --Set his storage for the quest
        setStorageNum = 1 -- To this value (starting the quest)
    },
        --At this point the player should of finished the quest and their storage value should of been changed to show he has completed it.
    [2] = {
        words = {"quest", "mission", "adventure", "task"},
        reqStorage = 30000,
        reqStorageNum = 2,
        reply = "Thank you! Those pests have been destorying all of my wine.",
        setStorage = 30000,
        setStorageNum = 3
        items = {
            [1] = {itemid = 2152, amount = 2}
        },
        exp = 100
    }
}


local function greetCallback(cid)
    return true
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if msg then
        for i = 1, #messages do
            if string.lower(msg) == messages[i].words then
                if player:getStorageValue(messages[i].reqStorage) == messages[i].reqStorageNum then
                    self:say(messages[i].reply, cid)
                    
                    if messages[i].setStorage then
                        player:setStorageValue(messages[i].setStorage, messages[i].setStorageNum)
                    end
                    
                    if messages[i].items then
                        for x = 1, #messages[i].items do
                            player:addItem(messages[i].items[x].itemid, messages[i].items[x].amount)
                        end
                    end
                    
                    if messages[i].exp then
                        player:addExperience(messages[i].exp)
                    end
                end
            end
        end
    end
    return true
end

local function onAddFocus(cid)
end

local function onReleaseFocus(cid)
end

npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())