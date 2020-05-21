local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
	function onThink()
		if not npcHandler:isFocused(cid) then
				Npc():setDirection(DIRECTION_SOUTH)
			end
		npcHandler:onThink()
	end
local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, 'light') then
			if player:getStorageValue(Storage.lightBearer) == -1 and player:getGroup():getAccess() then
				player:learnSpell("Light")
				player:learnSpell("Great Light")
				player:learnSpell("Dismiss Light")
				player:setStorageValue(Storage.lightBearer, 0)
				player:save()
				npcHandler:say({
					'Admin, well, why didn\'t you say so? You now have light, my friend! Enjoy the quest.'
				}, cid)
				elseif player:getStorageValue(Storage.lightBearer) == -1 then
					player:learnSpell("Light")
					player:setStorageValue(Storage.lightBearer, 0)
					player:save()
					npcHandler:say({
						'An atrocious terror has broken through to the world of Decapitated Soul! Bringing with it, eternal darkness.', 
						'The Lord of the Light, needs the help of brave adventurers, like yourself, to help relight the basins of the world.',
						'As the mortal servant to, The Lord of The Light, I vow to assist the brave adventurers on the quest to save our world from this Darkness.',
						'In doing so, I grant you {utevo lux}, to help guide your way. Good luck adventurer, you will surely need it.'
					}, cid)
		elseif player:getStorageValue(Storage.lightBearerComplete) == 2 then
			npcHandler:say('You again? Don\'t you have other things to do?', cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.lightBearer) >= 0 and player:getStorageValue(Storage.lightBearerComplete) ~= 1 then
			npcHandler:say('You only have '.. player:getStorageValue(Storage.lightBearer) ..' coal basins lit, why are you bothering me already?', cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.lightBearerComplete) == 1 and player:getGroup():getAccess() then
			npcHandler:say('For you, everything is free.. Yet you still want more?', cid)
			npcHandler.topic[cid] = 3
		elseif player:getStorageValue(Storage.lightBearerComplete) == 1 then
			npcHandler:say('My friend, For a mere {100000} gold I will grant you the power needed to control light. Are you interested?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'no') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('Quit wasting my time, '.. player:getName() ..'!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 3 then
			npcHandler:say('Of course you do.. ..i..', cid)
			npcHandler:releaseFocus(cid)
			player:setStorageValue(Storage.lightBearerComplete, 2)
			player:save()
		elseif npcHandler.topic[cid] == 1 then
			if player:removeMoneyNpc(100000) then
				player:learnSpell("Great Light")
				player:learnSpell("Dismiss Light")
				player:setStorageValue(Storage.lightBearerComplete, 2)
				player:save()
				npcHandler:say({
					'As the terrors continue to devour our resources.', 
					'The Lord of the Light continues to slowly dwindle away.',
					'I will no longer be able to assist in your journeys, it is in your hands now.',
					'Please, make use of {utevo gran lux} and {utevo dis}, as well as any other light in this world.', 
					'May the light be with you.'
				}, cid)
			else
			local smite = player:getMaxHealth() / 4
				player:addHealth(-smite)
				player:getPosition():sendMagicEffect(CONST_ME_HOLY_JUDGEMENT)
				npcHandler:say('How dare you waste my time! I smite you!', cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
