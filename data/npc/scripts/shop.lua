local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)            npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                    npcHandler:onThink()                    end



local shopItems = {
    ["boots of haste"] = {
        id = 2195, -- the item id of the item from items.xml
        buy = 100, -- how much they cost to buy
        sell = 54, -- how much you get for selling them
        desc = 'boots of haste' -- a description of the item
    },
    ["boots of waterwalking"] = {
        id = 2358,
        buy = 10,
        sell = 5,
        desc = 'boots of waterwalking'
    },
    ["pair of soft boots"] = {
        id = 2640,
        buy = 10,
        sell = 5,
        desc = 'pair of soft boots'
    },
    ["patched boots"] = {
        id = 2641,
        buy = 10,
        sell = 5,
        desc = 'patched boots'
    },
    ["sandals"] = {
        id = 2642,
        buy = 10,
        sell = 5,
        desc = 'sandals'
    }
}


local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

--[[
      This checks to make sure shopItems is a table in case you make a clerical error adding in entries
      If you add entries into the shopItems table and load this script and see no items in the shop
      that means you have an error in the shopItems table, so look it over again to see what you missed :)
  ]]
if type(shopItems) == "table" then
    for name, v in pairs(shopItems) do
        shopModule:addBuyableItem({name}, shopItems[name].id, shopItems[name].buy, name)
        shopModule:addSellableItem({name, name}, shopItems[name].id, shopItems[name].sell, shopItems[name].desc)
    end
end

-- change what is in the quotes to your greeting
npcHandler.messages[MESSAGE_GREET] = "Hello, |PLAYERNAME| I sell foot wear please say {trade} to see what we have to offer."
-- this activates when the trade window opens, you can edit what is in the quotes as well
npcHandler.messages[MESSAGE_SENDTRADE] = "As you can see we are very competitive with our prices."

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    -- no need anything here
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())