
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function onThink()
    if not npcHandler:isFocused(cid) then
            Npc():setDirection(DIRECTION_SOUTH)
        end
local lastSound = 0
    if lastSound < os.time() then
        lastSound = (os.time() + 10)
    if math.random(100) < 8 then
        Npc():say("Need some info? Maybe I can help.", TALKTYPE_MONSTER_SAY)
    end
    npcHandler:onThink()
    end
end
-- add more useful info for Oldrak, Demon Oak

--main menus
keywordHandler:addKeyword({'monsters'}, StdModule.say, {npcHandler = npcHandler, text = "Would you like info on {low}, {mid}, or {upper} level monsters?"})
keywordHandler:addKeyword({'info'}, StdModule.say, {npcHandler = npcHandler, text = "Info: {autoloot}, {vip}, {portals}, {trainers}, {store}, {quest} or {more}?"})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = "Quest: Looking for {Oldrak} or can't figure out how to do {Demon Oak}?"})


-- sub menus
keywordHandler:addKeyword({'low'}, StdModule.say, {npcHandler = npcHandler, text = "Low Level Monsters: {Cyclops}, {Hatchlings}, {Dragons}, {Vampires}, {Heroes}, {Black Knights}, {Dragon Lords}, {Stormblast}"})
keywordHandler:addKeyword({'mid'}, StdModule.say, {npcHandler = npcHandler, text = "{Hydras}, {Warlocks}, {Demodras}, {Lost Souls}, {Demons}, {Orshabaals}, {Juggernauts}, {Grim Reapers}, {Ghastly Dragons}, {Frost Dragons}, {Angel of Death} "})
keywordHandler:addKeyword({'upper'}, StdModule.say, {npcHandler = npcHandler, text = "{Trigammas}, {Apocalypse}"})

-- monsters low
keywordHandler:addKeyword({'cyclops'}, StdModule.say, {npcHandler = npcHandler, text = "Cyclops: Go upstairs, then go {East} once out of temple."})
keywordHandler:addKeyword({'hatchlings'}, StdModule.say, {npcHandler = npcHandler, text = "Hatchlings: Use the wagon to ride to first stop. Go up stairs, then go {Southeast} from the station."})
keywordHandler:addKeyword({'dragons'}, StdModule.say, {npcHandler = npcHandler, text = "Dragons: Ride the wagon to the 2nd stop. Go up stairs, then proceed {East}."})
keywordHandler:addKeyword({'vampires'}, StdModule.say, {npcHandler = npcHandler, text = "Vampires: Ride the wagon to the first stop. Go upstairs, then proceed {Southwest}. Just past the cemetery."})
keywordHandler:addKeyword({'heroes'}, StdModule.say, {npcHandler = npcHandler, text = "Heros: Located underneath the {Tavern} in {Southwest} corner of Drogheda, {East} of Mill."})
keywordHandler:addKeyword({'black knights'}, StdModule.say, {npcHandler = npcHandler, text = "Black Knights: Located in {Southwest} corner of {Cyclops} section."})
keywordHandler:addKeyword({'dragon lords'}, StdModule.say, {npcHandler = npcHandler, text = "Dragon Lords: Ride the wagon to the 2nd stop. Go up stairs, then proceed {East}. Stair entrance is on {Southern} mountain."})
keywordHandler:addKeyword({'stormblast'}, StdModule.say, {npcHandler = npcHandler, text = "Catacombs: Ride the wagon near Damon back to Keaton. Return to the Skeleton and Bat spawn. \nProceed {Northeast}, until you find a door marked WARNING!"})

-- monsters mid
keywordHandler:addKeyword({'hydras'}, StdModule.say, {npcHandler = npcHandler, text = "Hydras: Located by using the Teleport to {Queimada} and going {East}."})
keywordHandler:addKeyword({'warlocks'}, StdModule.say, {npcHandler = npcHandler, text = "Warlocks: Located in the {West} side of Quiemada. Use the {Sorcerer Statue}."})
keywordHandler:addKeyword({'demodras'}, StdModule.say, {npcHandler = npcHandler, text = "Demodras: Located in the {Southwest} corner of the green dragon spawn, botton level."})
keywordHandler:addKeyword({'lost souls'}, StdModule.say, {npcHandler = npcHandler, text = "Lost Souls|Dark Torturers: Found by using the {Purgatory Isle Teleport} and exploring {North} of the Temple."})
keywordHandler:addKeyword({'demons'}, StdModule.say, {npcHandler = npcHandler, text = "Demons: Located by using the steps in the {Lost Souls} building, bottom floor and to the {North}."})
keywordHandler:addKeyword({'orshabaals'}, StdModule.say, {npcHandler = npcHandler, text = "Orshabaals: Located deep within the {Southwest} corner of the {Demon} Section."})
keywordHandler:addKeyword({'juggernauts'}, StdModule.say, {npcHandler = npcHandler, text = "Juggernauts: Located in the far {Eastern} section of the hydras."})
keywordHandler:addKeyword({'grim reaper'}, StdModule.say, {npcHandler = npcHandler, text = "Grim Reapers: Located deep underneath the {Vampire} Section."})
keywordHandler:addKeyword({'ghastly dragons'}, StdModule.say, {npcHandler = npcHandler, text = "Ghastly Dragons: Located in the {Western} section of the Dragon Lords, above ground."})
keywordHandler:addKeyword({'frost dragons'}, StdModule.say, {npcHandler = npcHandler, text = "Frost Dragons: Located in {Frozen Wastes}, in a cavern located {South} of the temple."})
keywordHandler:addKeyword({'angel of death'}, StdModule.say, {npcHandler = npcHandler, text = "Frozen Hell: Deep within the {Frost Dragons}, you will find the portal. Make your way through the frozen labyrinth. Find the center."})

-- monster upper
keywordHandler:addKeyword({'trigammas'}, StdModule.say, {npcHandler = npcHandler, text = "Trigammas: Located in the {Northeast} corner of the hydras, above ground."})
keywordHandler:addKeyword({'apocalypse'}, StdModule.say, {npcHandler = npcHandler, text = "Apocalypse: Located deep within the {Warlock} Section, find {Willy}."})

--addition info (bullets alt 0149)
keywordHandler:addKeyword({'autoloot'}, StdModule.say, {npcHandler = npcHandler, text = "\n• How to use commands • \n• {!autoloot add, itemName} example: !autoloot add, lump of coal \n• {!autoloot remove, itemName} example: !autoloot remove, lump of coal \n• {!autoloot show} shows all items currently on autoloot. \n• {!autoloot clear} Clears all autoloot items. \n• Autoloot system only allows adding {5} items at a time."}) 
keywordHandler:addKeyword({'vip'}, StdModule.say, {npcHandler = npcHandler, text = "\nVIP: Applied to your whole account! \n• {Double Experience} \n• {Bonus Gold} on loot \n• {VIP Commands} [!aol, !bless, !t, !portal] \n• {Portal System}"}) 
keywordHandler:addKeyword({'portals'}, StdModule.say, {npcHandler = npcHandler, text = "Portals: Applied on a Player basis, not whole Account. \nOnce you discover, as a {VIP} player, you gain use of that portal. \nPortals {will not} save to that player, if Account is non-VIP. Once Portal is discovered, as a VIP, it will not reset once VIP runs out."}) 
keywordHandler:addKeyword({'trainers'}, StdModule.say, {npcHandler = npcHandler, text = "Trainers: You have to complete the first quest for {Soraya}, to use trainers. \nIt will cost you {1 Soul} per minute, in order to train."}) 
keywordHandler:addKeyword({'store'}, StdModule.say, {npcHandler = npcHandler, text = "The Decapitated Soul version of OTClient is Experimental. \nThere is not a functioning ingame store within OTClient at this time. \nYou will have to use the Tibia Client (found on our downloads page), in order to redeem your coins."}) 
keywordHandler:addKeyword({'more'}, StdModule.say, {npcHandler = npcHandler, text = "If you would like info on a topic and cannot find it here, please ask in {World Chat} or suggest info on our website."}) 

-- Quest info
keywordHandler:addKeyword({'oldrak'}, StdModule.say, {npcHandler = npcHandler, text = "Oldrak: Go to the {Cemetery} just before Vampires, {Southwest) Drogheda. You will have to look hard. He is in hiding."}) 
keywordHandler:addKeyword({'demon oak'}, StdModule.say, {npcHandler = npcHandler, text = "Demon Oak is a multi-part quest. \n• First you must discover the {Demon Oak}, which is located just {East} of Dragon Hatchlings.\n• Peek in at the Demon Oak on the {flame spots}, before entering, to discover the perimeter of the Oak..\n• Enter the Demon Oak, to complete the exploration. \n• Next, you will have to have an axe, for {Oldrak} to bless. Check the farm for an axe. \n• Once Oldrak has {Blessed} your axe, make your way back to the {Demon Oak}. \n• Only {One Player} may enter Demon Oak at a time. \n• Proceed to {chop} all four sections of the Demon Oak, {left Arm, Right Arm, Face, & Bird}.\n• Approximately {3} waves of monsters will spawn per each section. \n• Once you get to the last section, be ready to fight the Boss, anytime after the second wave.\n• Don't forget to finish chopping the Oak, one last hit after boss!\n• Go back to the Cemetery to report back to {Oldrak}.\n• Oldrak will send you to inspect an old grave of {Dr. Henry Walton Jones}.\n• If you have made it this far, Congratulations!"}) 


function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end	
    

    local player = Player(cid)

	-- look at Oswald's script for a better refrence
    if msgcontains(msg, "owner") then
        if player:getLevel() >= 350 then
            selfSay("Really? Go away Noob.", cid)
        else
            selfSay("Caduceus is the Proud onwer of " .. configManager.getString(configKeys.SERVER_NAME) .. ".", cid)
        end
        return true
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hey |PLAYERNAME|! \nI'm a Server Assistant and I can give the location of {monsters} which will be useful for completing quests or general {info} about " .. configManager.getString(configKeys.SERVER_NAME) .. "!")

npcHandler:addModule(FocusModule:new())