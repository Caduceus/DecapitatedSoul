local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local lastSound = 0
function onThink()
    if lastSound < os.time() then
        lastSound = (os.time() + 5)
        if math.random(100) < 15 then
            Npc():say("Now offering the latest in potion technology. Get them while they are fresh!", TALKTYPE_MONSTER_SAY)
        end
    end
    npcHandler:onThink()
end


local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. I sell any type of rune or potion you may need. I offer anything from single shots to backpacks of supplies. If you cannot figure out how to purchase backpacks of supplies ask me for {help}.")

shopModule:addBuyableItem({'magic lightwand'}, 2163, 400, 'magic lightwand')

--shopModule:addBuyableItem({'small health'}, 8704, 20, 1, 'small health potion')
--shopModule:addBuyableItem({'health potion'}, 7618, 175, 1, 'health potion')
--shopModule:addBuyableItem({'mana potion'}, 7620, 50, 1, 'mana potion')
--shopModule:addBuyableItem({'strong health'}, 7588, 100, 1, 'strong health potion')
--shopModule:addBuyableItem({'strong mana'}, 7589, 80, 1, 'strong mana potion')
shopModule:addBuyableItem({'great health'}, 7591, 190, 1, 'scaling health potion')
shopModule:addBuyableItem({'great mana'}, 7590, 120, 1, 'scaling mana potion')
--shopModule:addBuyableItem({'master mana'}, 22472, 500, 1, 'master mana potion')
--shopModule:addBuyableItem({'master spirit'}, 21245, 500, 1, 'master spirit potion')
shopModule:addBuyableItem({'scaling spirit'}, 8472, 175, 1, 'scaling spirit potion')
--shopModule:addBuyableItem({'ultimate health'}, 8473, 120, 1, 'ultimate health potion')
--shopModule:addBuyableItem({'master health'}, 22473, 500, 1, 'master health potion')
shopModule:addBuyableItem({'antidote potion'}, 8474, 50, 1, 'antidote potion')

shopModule:addSellableItem({'normal potion flask', 'normal flask'}, 7636, 5, 'empty small potion flask')
shopModule:addSellableItem({'strong potion flask', 'strong flask'}, 7634, 10, 'empty strong potion flask')
shopModule:addSellableItem({'great potion flask', 'great flask'}, 7635, 15, 'empty great potion flask')

--shopModule:addBuyableItem({'instense healing', 'ih'}, 2265, 50, 1, 'intense healing rune')
--shopModule:addBuyableItem({'ultimate healing'}, 2273, 175, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'blank rune'}, 2260, 100, 1, 'blank rune')
shopModule:addBuyableItem({'magic wall'}, 2293, 350, 3, 'magic wall rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 45, 3, 'destroy field rune')
shopModule:addBuyableItem({'light magic missile', 'lmm'}, 2287, 40, 10, 'light magic missile rune')
shopModule:addBuyableItem({'heavy magic missile', 'hmm'}, 2311, 120, 10, 'heavy magic missile rune')
shopModule:addBuyableItem({'great fireball'}, 2304, 150, 1, 'great fireball rune')
shopModule:addBuyableItem({'avalanche'}, 2274, 150, 1, 'avalanche rune')
shopModule:addBuyableItem({'explosion', 'explo'}, 2313, 250, 6, 'explosion rune')
shopModule:addBuyableItem({'sudden death'}, 2268, 200, 3, 'sudden death rune')
--shopModule:addBuyableItem({'death arrow'}, 2263, 300, 3, 'death arrow rune')
shopModule:addBuyableItem({'paralyze', 'para'}, 2278, 700, 1, 'paralyze rune')
shopModule:addBuyableItem({'animate dead'}, 2316, 375, 1, 'animate dead rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 80, 1, 'convince creature rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 210, 1, 'chameleon rune')
shopModule:addBuyableItem({'desintegrate'}, 2310, 80,  3, 'desintegreate rune')
--shopModule:addBuyableItem({'mana rune', 'mr'}, 2298, 55, 1, 'mana rune')
--shopModule:addBuyableItem({'intense mana rune'}, 2270, 125, 1, 'intense mana rune')
--shopModule:addBuyableItem({'ultimate mana rune'}, 2307, 175, 1, 'ultimate mana rune')


--shopModule:addBuyableItemContainer({'bp slhp'}, 2000, 8704, 4000, 10, 'backpack of small health potions')
--shopModule:addBuyableItemContainer({'bp hp'}, 2000, 7618, 350000, 100, 'backpack of health potions')
--shopModule:addBuyableItemContainer({'bp mp'}, 2001, 7620, 350000, 100, 'backpack of mana potions')
--shopModule:addBuyableItemContainer({'bp shp'}, 2000, 7588, 20000, 10, 'backpack of strong health potions')
--shopModule:addBuyableItemContainer({'bp smp'}, 2001, 7589, 16000, 10, 'backpack of strong mana potions')
shopModule:addBuyableItemContainer({'bp shp'}, 2000, 7591, 350000, 100, 'backpack of scaling health potions')
--shopModule:addBuyableItemContainer({'bp mmp'}, 2001, 22472, 1000000, 100, 'backpack of master mana potions')
--shopModule:addBuyableItemContainer({'bp msp'}, 10519, 21245, 1000000, 100, 'backpack of master spirit potions')
shopModule:addBuyableItemContainer({'bp ssp'}, 1999, 8472, 350000, 100, 'backpack of scaling spirit potions')
--shopModule:addBuyableItemContainer({'bp mhp'}, 2000, 22473, 1000000, 100, 'backpack of master health potions')
shopModule:addBuyableItemContainer({'bp ap'}, 2002, 8474, 20000, 1, 'backpack of antidote potions')
--shopModule:addBuyableItemContainer({'bp uh'}, 1998, 2273, 350000, 100, 'backpack of ultimate healing runes')
--shopModule:addBuyableItemContainer({'bp uhp'}, 2000, 8473, 400000, 100, 'backpack of ultimate health potions')
--shopModule:addBuyableItemContainer({'bp im'}, 2002, 2270, 250000, 100, 'backpack of intense mana runes')
--shopModule:addBuyableItemContainer({'bp um'}, 2000, 2307, 350000, 100, 'backpack of ultimate mana runes')
shopModule:addBuyableItemContainer({'bp smp'}, 2001, 7590, 350000, 100, 'backpack of scaling mana potions')
shopModule:addBuyableItemContainer({'bp sd'}, 2003, 2268, 400000, 200, 'backpack of sudden death runes')


--shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 2190, 500, 'wand of vortex')
--shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 1000, 'wand of dragonbreath')
--shopModule:addBuyableItem({'wand of decay', 'decay'}, 2188, 5000, 'wand of decay')
--shopModule:addBuyableItem({'wand of draconia', 'draconia'}, 8921, 7500, 'wand of draconia')
--shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 10000, 'wand of cosmic energy')
--shopModule:addBuyableItem({'wand of inferno', 'inferno'}, 2187, 15000, 'wand of inferno')

--shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182, 500, 'snakebite rod')
--shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186, 1000, 'moonlight rod')
--shopModule:addBuyableItem({'necrotic rod', 'necrotic'}, 2185, 5000, 'necrotic rod')
--shopModule:addBuyableItem({'northwind rod', 'northwind'}, 8911, 60000, 'northwind rod')
--shopModule:addBuyableItem({'terra rod', 'terra'}, 2181, 10000, 'terra rod')
--shopModule:addBuyableItem({'springsprout rod', 'springsprout'}, 8912, 18000, 'springsprout rod')

shopModule:addSellableItem({'wand of vortex', 'vortex'}, 2190, 250, 'wand of vortex')
shopModule:addSellableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 500, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of decay', 'decay'}, 2188, 2500, 'wand of decay')
shopModule:addSellableItem({'wand of draconia', 'draconia'}, 8921, 3750, 'wand of draconia')
shopModule:addSellableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 5000, 'wand of cosmic energy')
shopModule:addSellableItem({'wand of inferno', 'inferno'},2187, 7500, 'wand of inferno')
shopModule:addSellableItem({'wand of starstorm', 'starstorm'}, 8920, 9000, 'wand of starstorm')
shopModule:addSellableItem({'wand of voodoo', 'voodoo'}, 8922, 11000, 'wand of voodoo')

shopModule:addSellableItem({'snakebite rod', 'snakebite'}, 2182, 250,'snakebite rod')
shopModule:addSellableItem({'moonlight rod', 'moonlight'}, 2186, 500,   'moonlight rod')
shopModule:addSellableItem({'necrotic rod', 'necrotic'}, 2185, 2500, 'necrotic rod')
shopModule:addSellableItem({'northwind rod', 'northwind'}, 8911, 3750, 'northwind rod')
shopModule:addSellableItem({'terra rod', 'terra'}, 2181, 5000, 'terra rod')
shopModule:addSellableItem({'hailstorm rod', 'hailstorm'}, 2183, 7500, 'hailstorm rod')
shopModule:addSellableItem({'springsprout rod', 'springsprout'}, 8912, 9000, 'springsprout rod')
shopModule:addSellableItem({'underworld rod', 'underworld'}, 8910, 11000, 'underworld rod')
shopModule:addSellableItem({'northwind rod', 'northwind'}, 8911, 60000, 'northwind rod')


keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'To buy backpacks of supplies, try one of these: Scaling Health Potions ({buy bp smp}), Scaling Mana Potions ({buy bp smp}), Scaling Spirit Potions ({buy bp ssp}), Sudden Death Runes ({buy bp sd}).'})


npcHandler:addModule(FocusModule:new())
