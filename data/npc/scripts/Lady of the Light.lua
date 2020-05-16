local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
--function onThink()				npcHandler:onThink()					end
	function onThink()
		if not npcHandler:isFocused(cid) then
				Npc():setDirection(DIRECTION_EAST)
			end
		npcHandler:onThink()
	end
local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, 'light') then
		if player:getStorageValue(Storage.lightBearer) == -1 then
			player:learnSpell("Light")
			player:setStorageValue(Storage.lightBearer, 0)
			player:save()
			npcHandler:say({
				'Lots of words. ...', 
				'More words. ...',
				'you recieve {utevo lux}. ...', --grant the use of basic light
				'..i..'
			}, cid)
		elseif player:getStorageValue(Storage.lightBearerComplete) == 2 then
			npcHandler:say('You again? Don\'t you have other things to do?', cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.lightBearer) >= 0 and player:getStorageValue(Storage.lightBearerComplete) ~= 1 then
			npcHandler:say('You only have '.. player:getStorageValue(Storage.lightBearer) ..' coal basins lit, why are you bothering me already?', cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.lightBearerComplete) == 1 then
			npcHandler:say('My friend, For a mere {100000} gold I will grant you the energy you need. Are you interested?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'no') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('Quit wasting my time, '.. player:getName() ..'!', cid)
			npcHandler.topic[cid] = 0
			npcHandler:releaseFocus(cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			if player:removeMoneyNpc(100000) then
				--player:forgetSpell("Light") --may keep this spell, not sure yet
				player:learnSpell("Great Light")
				player:learnSpell("Dismiss Light")
				player:setStorageValue(Storage.lightBearerComplete, 2)
				player:save()
				npcHandler:say({
					'basis of lore. ...', 
					'long winded story. ...',
					'{utevo gran lux} {utevo dis}. ...', --grant the use of great light & dismiss light
					'You have what you want! Now leave me be.'
				}, cid)
			else
			local smite = player:getMaxHealth() / 4
				player:addHealth(-smite)
				player:getPosition():sendMagicEffect(CONST_ME_HOLY_JUDGEMENT)
				npcHandler:say('I smite you! You filthy bum.', cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
