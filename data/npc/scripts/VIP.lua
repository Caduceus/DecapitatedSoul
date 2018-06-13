local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if isInArray({"10 day", "10"}, msg) then
		npcHandler:say("Do you want to buy a 10 day VIP token for 10 Gold Bar?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0

		if not player:removeMoneyNpc(10000000) then
			npcHandler:say("Sorry, you don't have enough money.", cid)
			return true
		end

		player:addItem(10135, 1)
		npcHandler:say("Here you are. 10", cid)
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0
		npcHandler:say("Ok then.", cid)
	return true
	end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
if isInArray({"30 day", "30"}, msg) then
		npcHandler:say("Do you want to buy a 30 day VIP token for 15 Gold Bars?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0

		if not player:removeMoneyNpc(15000000) then
			npcHandler:say("Sorry, you don't have enough money.", cid)
			return true
		end

		player:addItem(10134, 1)
		npcHandler:say("Here you are. 30", cid)
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0
		npcHandler:say("Ok then.", cid)
	return true
	end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
if isInArray({"90 day", "90"}, msg) then
		npcHandler:say("Do you want to buy a 90 day VIP token for 25 Gold bars?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0

		if not player:removeMoneyNpc(25000000) then
			npcHandler:say("Sorry, you don't have enough money.", cid)
			return true
		end

		player:addItem(10133, 1)
		npcHandler:say("Thank you for playing on Decapitated Soul. 90", cid)
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0
		npcHandler:say("Ok then.", cid)
	end
	return true
	end
  end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
