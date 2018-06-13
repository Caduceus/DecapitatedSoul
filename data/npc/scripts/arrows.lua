local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                      npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
 
-- Huntsman rank:1
shopModule:addBuyableItem({'sniper arrow'}, 7364, 100, 'sniper arrow')
 
function onTradeRequest(cid)
    return getPlayerStorageValue(cid, 15001) >= 1
end
 
function storageSell(cid, itemid, ...)
    local sellItems2 = {11208, 11205, 10549}
    local storage = getPlayerStorageValue(cid, 15001)
    if isInArray(sellItems2, itemid) and (storage < 1) then
        -- check storages part
        selfSay("You can not this item.", cid)
        return false
    end
    return true
end
 
npcHandler:setCallback(CALLBACK_ONSELL, storageSell)
npcHandler:setCallback(CALLBACK_ONTRADEREQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())