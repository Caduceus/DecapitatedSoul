local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)               npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)            npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)    npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                        npcHandler:onThink() end


local lastSound = 0
function onThink()
local random = math.random(250)
    if lastSound < os.time() then
        lastSound = (os.time() + 20)
        if random <= 100 then
            Npc():say("Sir, Ma'am, have a gold coin to spare?", TALKTYPE_MONSTER_SAY)
        elseif random >= 101 and random <= 119 then
			Npc():say("Allergic to Water, Need Beer.", TALKTYPE_MONSTER_SAY)
        elseif random >= 120 and random <= 140 then
			Npc():say("Ex-Wife Had A Better Lawyer!", TALKTYPE_MONSTER_SAY)
		elseif random >= 141 and random <= 160 then
			Npc():say("16 Wives 7 Hungry Dogs 3 Thin Cats 25 Kids and Still Horny. Please help with loose change.", TALKTYPE_MONSTER_SAY)
		elseif random >= 161 and random <= 180 then
			Npc():say("Need Money To Get Drunk So That 2 Women Can Take Me Home and Molest Me!", TALKTYPE_MONSTER_SAY)
		elseif random >= 181 and random <= 200 then
			Npc():say("Smile If You Masturbate. Spare Change If You Enjoy It!", TALKTYPE_MONSTER_SAY)
		elseif random >= 201 and random <= 219 then
			Npc():say("All I Want Is A Hooker and A Case of Beer!", TALKTYPE_MONSTER_SAY)
		elseif random >= 220 then
			Npc():say("Need Money To Buy Fat Women!", TALKTYPE_MONSTER_SAY)
        end
        return true
    end
    npcHandler:onThink()
end


function creatureSayCallback(cid, type, msg)
  if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	
	if player:getStorageValue(2092) ~= 1 then
	   npcHandler:say("Who are you to judge. I don't want your help.", cid)
	   return false
	end
   
   if msgcontains(msg, 'help') then
   npcHandler:say("I need gold. Can you spend me 100 gold pieces?", cid)
   talk_state = 1
	
   elseif msgcontains(msg, 'yes') and talk_state == 1 and player:getMoney() >= 100 then
   npcHandler:say("Thank you very much. Can you spend me 500 more gold pieces? I will give you a nice hint.", cid)
   
   player:removeMoneyNpc(100)
   talk_state = 2
   elseif msgcontains(msg, 'yes') and talk_state == 1 and player:getMoney() < 100 then
   npcHandler:say("You\'ve not enough money for me.", cid)
   talk_state = 0
   elseif msgcontains(msg, 'no') and talk_state == 1 then
   npcHandler:say("Hmm, maybe next time.", cid)
   talk_state = 0
 
   elseif msgcontains(msg, 'yes') and talk_state == 2 and player:getMoney() >= 500 then
   player:removeMoneyNpc(500)
   npcHandler:say("That\'s great! I have stolen something from Dermot. You can buy it for 200 gold. Do you want to buy it?", cid)
   talk_state = 3
   elseif msgcontains(msg, 'yes') and talk_state == 2 and player:getMoney() < 500 then
   npcHandler:say("Sorry, that\'s not enough.", cid)
   talk_state = 0
   elseif msgcontains(msg, 'no') and talk_state == 2 then
   npcHandler:say("It was your decision.", cid)
   talk_state = 0
 
   elseif msgcontains(msg, 'yes') and talk_state == 3 and player:getMoney() >= 200 then
   npcHandler:say("Now you own a hot key.", cid)
   player:removeMoneyNpc(200)
   key = doPlayerAddItem(cid, 2092,1)
   doSetItemActionId(key,2092)
   doSetItemSpecialDescription(key, "(Key: 2092)")
   talk_state = 0
   elseif msgcontains(msg, 'yes') and talk_state == 3 and player:getMoney() < 200 then
   npcHandler:say("Pah! I said 200 gold. You don\'t have that much.", cid)
   talk_state = 0
   elseif msgcontains(msg, 'no') and talk_state == 3 then
   npcHandler:say("Ok. No problem. I\'ll find another buyer.", cid)
   talk_state = 0
 
   elseif msgcontains(msg, 'bye') and (talk_state >= 1 and talk_state <= 3) then
   npcHandler:say("Have a nice day.", cid)
   talk_state = 0
 
   end
   return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
shopModule:addBuyableItem({'shovel'}, 2554, 50)
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have no job. I am a beggar."})
keywordHandler:addKeyword({'beggar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have no gold and no job, so I am a beggar."})
keywordHandler:addKeyword({'gold'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I need gold. I love gold. I need help."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Simon. I am a very poor man."})
keywordHandler:addKeyword({'simon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Simon. The poorest human all over the continent."})
keywordHandler:addKeyword({'dermot'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The magistrate of the village. I heard he is selling something for the Fibula Dungeon."})
keywordHandler:addKeyword({'village'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "To the north is the village Fibula. A very small village."})
keywordHandler:addKeyword({'key'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Key? There are a lot of keys. Please change the topic."})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I heard a lot about the Fibula Dungeon. But I never was there."})
keywordHandler:addKeyword({'fibula'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I hate Fibula. Too many wolves are here."})
keywordHandler:addKeyword({'timur'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I hate Timur. He is too expensive. But sometimes I find maces and hatchets. Timur is buying these items."})
keywordHandler:addKeyword({'wolf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Please kill them ... ALL."})
keywordHandler:addKeyword({'flute'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Har, har. The stupid Dermot lost his flute. I know that some minotaurs have it in their treasure room."})
keywordHandler:addKeyword({'mino'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Very rich monsters. But they are too strong for me. However, there are even stronger monsters."})
keywordHandler:addKeyword({'treasure'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I know there are two rooms. And I know you can pass only the first door. The second door can't be opened."})
keywordHandler:addKeyword({'giant spider'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I know that terrible monster. It killed the fishers on the isle to the north"})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The strongest monster I know is the giant spider."})
keywordHandler:addKeyword({'jetty'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I hate this jetty. I have never seen a ship here."})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There is a large sea-monster outside. I think there is no gritty captain to sail in this quarter."})
keywordHandler:addKeyword({'dirt nap'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hehe, do you have a shovel? I can sell you a shovel if you want to dig your own grave."})
npcHandler:addModule(FocusModule:new())