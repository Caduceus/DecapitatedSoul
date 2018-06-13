local marks = {
    [1]={{x=1018,y=939,z=7},"Temple",MAPMARK_TEMPLE},
    [2]={{x=1057,y=931,z=7},"Cyclops",MAPMARK_STAR},
    [3]={{x=1054,y=1158,z=7},"Hatchlings",MAPMARK_STAR},
    [4]={{x=1136,y=1152,z=7},"Dragons",MAPMARK_STAR},
    [5]={{x=941,y=1136,z=7},"Vampires",MAPMARK_STAR},
    [6]={{x=1163,y=1184,z=7},"Dragon Lords",MAPMARK_STAR},
    [7]={{x=1136,y=1139,z=7},"Catacombs",MAPMARK_EXCLAMATION},
    [8]={{x=970,y=1050,z=7},"Heros",MAPMARK_STAR},
    [9]={{x=1015,y=933,z=7},"Shops - Upstairs",MAPMARK_BAG},
    [10]={{x=1031,y=940,z=9},"Banker",MAPMARK_DOLLAR},
    
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)        npcHandler:onCreatureAppear(cid)        end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()        npcHandler:onThink()        end

function  creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
    return false
end

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
     local player = Player(cid)
     if msg == "map" then
      for i = 1, #marks do
       player:addMapMark(marks[i][1],marks[i][3],marks[i][2])
      end
      selfSay('I have marked your map for you, good luck!', cid)
      talkState[talkUser] = 0
      elseif msg == "home" then
      player:setTown(Town(1))
      selfSay('It is done! Goodbye.', cid)
      talkState[talkUser] = 0
     else
    selfSay('Okay, goodbye.', cid)
    talkState[talkUser] = 0
   end
   return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())