local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)


function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)

    if(npcHandler.focus ~= cid) then
        return false
    end
    
    if msgcontains(msg,'spells') then
        --if getPlayerVocation(cid) == 4 or getPlayerVocation(cid) == 8 then
            selfSay('Which level would you like to learn {spells} for 100, 150 or 200?')
        else
            selfSay('Sorry, I only sell {spells}.')
        end
    --end
return 1    
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

local node1 = keywordHandler:addKeyword({'holy smokes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Would you like to find person for 20cc?'})
node1:addChildKeyword({'yes'}, StdModule.learnSpell, {npcHandler = npcHandler, premium = false, spellName = 'Holy Smokes', vocation = 10, price = 200000, level = 100})
node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Cant you handle the power of the spell?', reset = true})


local node2 = keywordHandler:addKeyword({'taunter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Would you like to learn taunter for 150k?'})
node2:addChildKeyword({'yes'}, StdModule.learnSpell, {npcHandler = npcHandler, premium = false, spellName = 'Taunter', vocation = 10, price = 150000, level = 150})
node2:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Cant you handle the power of the spell?', reset = true})


local node3 = keywordHandler:addKeyword({'ultra protection'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Would you like to learn ultra protection for 300k?'})
node3:addChildKeyword({'yes'}, StdModule.learnSpell, {npcHandler = npcHandler, premium = false, spellName = 'Ultra Protection', vocation = 8, price = 300000, level = 200})
node3:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Cant you handle the power of the spell?', reset = true})

npcHandler:addModule(FocusModule:new())