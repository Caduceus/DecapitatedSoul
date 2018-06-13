local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local node1 = keywordHandler:addKeyword({'promo','promotion'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Yea, sure..I can give you a promotion.. Does 2 cc sound ok?'})
	node1:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, cost = 20000, level = 20, premium = false, text = 'Well, here you go.. You know.. back in my day.. I did not have those promotions... '})
	node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You do not need those ole promotions anyway...', reset = true})

npcHandler:addModule(FocusModule:new())
