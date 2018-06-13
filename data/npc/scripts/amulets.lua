local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. I sell shit.")


shopModule:addBuyableItem({'terra amulet'}, 7887, 1000, 1, 'terra amulet')

--[[shopModule:addBuyableItemContainer({'bp slhp'}, 2000, 8704, 4000, 10, 'backpack of small health potions')
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
--shopModule:addBuyableItem({'springsprout rod', 'springsprout'}, 8912, 18000, 'springsprout rod')]]

--[[shopModule:addSellableItem({'wand of vortex', 'vortex'}, 2190, 250, 'wand of vortex')
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
shopModule:addSellableItem({'northwind rod', 'northwind'}, 8911, 60000, 'northwind rod')]]


npcHandler:addModule(FocusModule:new())
