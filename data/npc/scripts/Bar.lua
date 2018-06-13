local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'mug of beer'}, 2012, 150, 3, 'mug of beer')
shopModule:addBuyableItem({'flask of rum'}, 2009, 150, 27, 'flask of rum')
shopModule:addBuyableItem({'mug of mead'}, 2012, 150, 43, 'mug of mead')
shopModule:addBuyableItem({'wine'}, 10150, 150, 15, 'glass of wine')

npcHandler:addModule(FocusModule:new())