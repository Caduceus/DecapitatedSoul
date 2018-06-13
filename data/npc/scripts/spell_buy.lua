local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg) end
function onThink()  npcHandler:onThink() end

npcHandler:setMessage(MESSAGE_GREET, "Hello, |PLAYERNAME|. Are you looking to buy some {spells}?")

local PremiumSpells = false
local AllSpells = false
-- 1,5,11 Sorcerer
-- 2,6,12 Druid
-- 3,7,13 Paladin
-- 4,8,14 Knight
-- 9,10,15 Templar
local spells = {
-- item id's have to be unique
    [2160] = { buy = 20000, spell = "Ultra Protection", name = "Level 200: ultra protection", vocations = {4,8,14}, level = 20, premium = 0},
    [2217] = { buy = 20000, spell = "Holy Smokes", name = "Level 100: holy smokes", vocations = {9,10,15}, level = 10, premium = 0},
    [2275] = { buy = 20000, spell = "Taunter", name = "Level 150: Taunter", vocations = {9,10,15}, level = 10, premium = 0},

}

local function creatureSayCallback(cid, type, msg)

    if not npcHandler:isFocused(cid) then
        return false
    end
   
    local shopWindow = {}
    local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid

    local function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
    local npc = Npc()
        npc:say("You have choosen the spell: " .. spells[item].spell .. " which costs " .. spells[item].buy .. " gold.", TALKTYPE_PRIVATE_NP)
       
       
       
        local player = Player(cid)
        if player:hasLearnedSpell(spells[item].spell) then
            npc:say("You already know this spell.", TALKTYPE_PRIVATE_NP)
            return false
        end
     
        if player:getLevel() < spells[item].level then
            npc:say("You need to obtain a level of " .. spells[item].level .. " or higher to be able to learn this spell.", TALKTYPE_PRIVATE_NP)
            return false
        end

        if not isInArray(spells[item].vocations, player:getVocation():getId()) then
            npc:say("This spell is not for your vocation.", TALKTYPE_PRIVATE_NP)
            return false
        end

        if PremiumSpells and (spells[item].premium == 1) and not player:isPremium() then
            npc:say("You need to be premium in order to obtain this spell.", TALKTYPE_PRIVATE_NP)
            return false
        end
 
        if player:getMoney() < spells[item].buy then
            npc:say("You don't have enough money.", TALKTYPE_PRIVATE_NP)
            return false
        end

        player:removeMoneyNpc(spells[item].buy)
        player:learnSpell(spells[item].spell)
        player:getPosition():sendMagicEffect(12)
        npc:say("You have learned " .. spells[item].spell .. ".", TALKTYPE_PRIVATE_NP)
        return true
    end

    local player = Player(cid)
    if msgcontains(msg, "spells") then
        npcHandler:say("Here are the spells that you can learn from me.", cid)
        for var, item in pairs(spells) do
            if not AllSpells then
                if not player:hasLearnedSpell(item.spell) then
                    if player:getLevel() >= item.level then
                        if isInArray(item.vocations, player:getVocation():getId()) then
                            if PremiumSpells then
                                if (item.premium == 1) and player:isPremium() then
                                    table.insert(shopWindow, {id = var, subType = 0, buy = item.buy, sell = 0, name = item.name})
                                end
                            else
                                table.insert(shopWindow, {id = var, subType = 0, buy = item.buy, sell = 0, name = item.name})
                            end
                        end
                    end
                end
            else
                table.insert(shopWindow, {id = var, subType = 0, buy = item.buy, sell = 0, name = item.name})
            end
        end
        openShopWindow(cid, shopWindow, onBuy, onSell)
    end
    return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Bye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, have a nice day!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())