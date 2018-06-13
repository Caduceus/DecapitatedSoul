local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
local talkState = {}
local rtnt = {}
function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)             end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)         npcHandler:onCreatureSay(cid, type, msg)     end
function onThink()                             npcHandler:onThink()                         end

npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. I sell individual addons for a nominal fee! Just say {addons} or {help} if you don't know what to do.")

addoninfo = {
['first citizen addon'] = {cost = 5000, items = {}, outfit_female = 136, outfit_male = 128, addon = 1, storageID = 10042},
['second citizen addon'] = {cost = 10000, items = {}, outfit_female = 136, outfit_male = 128, addon = 2, storageID = 10043},
['first hunter addon'] = {cost = 5000, items = {}, outfit_female = 137, outfit_male = 129, addon = 1, storageID = 10044},
['second hunter addon'] = {cost = 10000, items = {}, outfit_female = 137, outfit_male = 129, addon = 2, storageID = 10045},
['first knight addon'] = {cost = 5000, items = {}, outfit_female = 139, outfit_male = 131, addon = 1, storageID = 10046},
['second knight addon'] = {cost = 10000, items = {}, outfit_female = 139, outfit_male = 131, addon = 2, storageID = 10047},
['first mage addon'] = {cost = 5000, items = {}, outfit_female = 138, outfit_male = 130, addon = 1, storageID = 10048},
['second mage addon'] = {cost = 10000, items = {}, outfit_female = 138, outfit_male = 130, addon = 2, storageID = 10049},
['first summoner addon'] = {cost = 5000, items = {}, outfit_female = 141, outfit_male = 133, addon = 1, storageID = 10050},
['second summoner addon'] = {cost = 10000, items = {}, outfit_female = 141, outfit_male = 133, addon = 2, storageID = 10051},
['first barbarian addon'] = {cost = 5000, items = {}, outfit_female = 147, outfit_male = 143, addon = 1, storageID = 10011},
['second barbarian addon'] = {cost = 10000, items = {}, outfit_female = 147, outfit_male = 143, addon = 2, storageID = 10012},
['first druid addon'] = {cost = 5000, items = {}, outfit_female = 148, outfit_male = 144, addon = 1, storageID = 10013},
['second druid addon'] = {cost = 10000, items = {}, outfit_female = 148, outfit_male = 144, addon = 2, storageID = 10014},
['first nobleman addon'] = {cost = 5000, items = {}, outfit_female = 140, outfit_male = 132, addon = 1, storageID = 10015},
['second nobleman addon'] = {cost = 10000, items = {}, outfit_female = 140, outfit_male = 132, addon = 2, storageID = 10016},
['first oriental addon'] = {cost = 5000, items = {}, outfit_female = 150, outfit_male = 146, addon = 1, storageID = 10017},
['second oriental addon'] = {cost = 10000, items = {}, outfit_female = 150, outfit_male = 146, addon = 2, storageID = 10018},
['first warrior addon'] = {cost = 5000, items = {}, outfit_female = 142, outfit_male = 134, addon = 1, storageID = 10019},
['second warrior addon'] = {cost = 10000, items = {}, outfit_female = 142, outfit_male = 134, addon = 2, storageID = 10020},
['first wizard addon'] = {cost = 5000, items = {}, outfit_female = 149, outfit_male = 145, addon = 1, storageID = 10021},
['second wizard addon'] = {cost = 10000, items = {}, outfit_female = 149, outfit_male = 145, addon = 2, storageID = 10022},
['first assassin addon'] = {cost = 5000, items = {}, outfit_female = 156, outfit_male = 152, addon = 1, storageID = 10023},
['second assassin addon'] = {cost = 10000, items = {}, outfit_female = 156, outfit_male = 152, addon = 2, storageID = 10024},
['first beggar addon'] = {cost = 5000, items = {}, outfit_female = 157, outfit_male = 153, addon = 1, storageID = 10025},
['second beggar addon'] = {cost = 10000, items = {}, outfit_female = 157, outfit_male = 153, addon = 2, storageID = 10026},
['first pirate addon'] = {cost = 5000, items = {}, outfit_female = 155, outfit_male = 151, addon = 1, storageID = 10027},
['second pirate addon'] = {cost = 10000, items = {}, outfit_female = 155, outfit_male = 151, addon = 2, storageID = 10028},
['first shaman addon'] = {cost = 5000, items = {}, outfit_female = 158, outfit_male = 154, addon = 1, storageID = 10029},
['second shaman addon'] = {cost = 10000, items = {}, outfit_female = 158, outfit_male = 154, addon = 2, storageID = 10030},
['first norseman addon'] = {cost = 5000, items = {}, outfit_female = 252, outfit_male = 251, addon = 1, storageID = 10031},
['second norseman addon'] = {cost = 10000, items = {}, outfit_female = 252, outfit_male = 251, addon = 2, storageID = 10032},
['first jester addon'] = {cost = 10000, items = {}, outfit_female = 270, outfit_male = 273, addon = 1, storageID = 10033},
['second jester addon'] = {cost = 100000, items = {}, outfit_female = 270, outfit_male = 273, addon = 2, storageID = 10034},
['first demonhunter addon'] = {cost = 10000, items = {}, outfit_female = 288, outfit_male = 289, addon = 1, storageID = 10035},
['second demonhunter addon'] = {cost = 100000, items = {}, outfit_female = 288, outfit_male = 289, addon = 2, storageID = 10036},
['first nightmare addon'] = {cost = 10000, items = {}, outfit_female = 269, outfit_male = 268, addon = 1, storageID = 10037},
['second nightmare addon'] = {cost = 100000, items = {}, outfit_female = 269, outfit_male = 268, addon = 2, storageID = 10038},
['first brotherhood addon'] = {cost = 10000, items = {}, outfit_female = 279, outfit_male = 278, addon = 1, storageID = 10039},
['second brotherhood addon'] = {cost = 100000, items = {}, outfit_female = 279, outfit_male = 278, addon = 2, storageID = 10040},
['first yalaharian addon'] = {cost = 10000, items = {}, outfit_female = 324, outfit_male = 325, addon = 1, storageID = 10041},
['second yalaharian addon'] = {cost = 100000, items = {}, outfit_female = 324, outfit_male = 325, addon = 2, storageID = 10052}
-- next storage 10053	-- next storage 10053	-- next storage 10053	-- next storage 10053	-- next storage 10053	-- next storage 10053	-- next storage 10053 --
}
local o = {'citizen', 'hunter', 'knight', 'mage', 'nobleman', 'summoner', 'warrior', 'barbarian', 'druid', 'wizard', 'oriental', 'pirate', 'assassin', 'beggar', 'shaman', 'norseman', 'nighmare', 'jester', 'yalaharian', 'brotherhood', 'demonhunter'}
function creatureSayCallback(cid, type, msg)
local talkUser = cid

	if(not npcHandler:isFocused(cid)) then
		return false
	end

	if addoninfo[msg] ~= nil then
		if (getPlayerStorageValue(cid, addoninfo[msg].storageID) ~= -1) then
				npcHandler:say('You already have this addon!', cid)
				npcHandler:resetNpc()
		else
		local itemsTable = addoninfo[msg].items
		local items_list = ''
			if table.maxn(itemsTable) > 0 then
				for i = 1, table.maxn(itemsTable) do
					local item = itemsTable[i]
					items_list = items_list .. item[2] .. ' ' .. ItemType(item[1]):getName()
					if i ~= table.maxn(itemsTable) then
						items_list = items_list .. ', '
					end
				end
			end
		local text = ''
			if (addoninfo[msg].cost > 0) then
				text = addoninfo[msg].cost .. ' gp'
			elseif table.maxn(addoninfo[msg].items) then
				text = items_list
			elseif (addoninfo[msg].cost > 0) and table.maxn(addoninfo[msg].items) then
				text = items_list .. ' and ' .. addoninfo[msg].cost .. ' gp'
			end
			npcHandler:say('For ' .. msg .. ' you will need ' .. text .. '. Do you have it all with you?', cid)
			rtnt[talkUser] = msg
			talkState[talkUser] = addoninfo[msg].storageID
			return true
		end
	elseif msgcontains(msg, "yes") then
		if (talkState[talkUser] > 10010 and talkState[talkUser] < 10100) then
			local items_number = 0
			if table.maxn(addoninfo[rtnt[talkUser]].items) > 0 then
				for i = 1, table.maxn(addoninfo[rtnt[talkUser]].items) do
					local item = addoninfo[rtnt[talkUser]].items[i]
					if (getPlayerItemCount(cid,item[1]) >= item[2]) then
						items_number = items_number + 1
					end
				end
			end
			if(getPlayerMoney(cid) >= addoninfo[rtnt[talkUser]].cost) and (items_number == table.maxn(addoninfo[rtnt[talkUser]].items)) then
				doPlayerRemoveMoney(cid, addoninfo[rtnt[talkUser]].cost)
				if table.maxn(addoninfo[rtnt[talkUser]].items) > 0 then
					for i = 1, table.maxn(addoninfo[rtnt[talkUser]].items) do
						local item = addoninfo[rtnt[talkUser]].items[i]
						doPlayerRemoveItem(cid,item[1],item[2])
					end
				end
				doPlayerAddOutfit(cid, addoninfo[rtnt[talkUser]].outfit_male, addoninfo[rtnt[talkUser]].addon)
				doPlayerAddOutfit(cid, addoninfo[rtnt[talkUser]].outfit_female, addoninfo[rtnt[talkUser]].addon)
				setPlayerStorageValue(cid,addoninfo[rtnt[talkUser]].storageID,1)
				npcHandler:say('Here you are.', cid)
			else
				npcHandler:say('You do not have needed items!', cid)
			end
			rtnt[talkUser] = nil
			talkState[talkUser] = 0
			npcHandler:resetNpc()
			return true
		end
	elseif msgcontains(msg, "addon") then
		npcHandler:say('I can give you addons for {' .. table.concat(o, "}, {") .. '} outfits.', cid)
		rtnt[talkUser] = nil
		talkState[talkUser] = 0
		npcHandler:resetNpc()
		return true
	elseif msgcontains(msg, "help") then
		npcHandler:say('To buy the first addon say \'first NAME addon\', for the second addon say \'second NAME addon\'.  {Example: first citizen addon} or {second citizen addon}.' , cid)
		rtnt[talkUser] = nil
		talkState[talkUser] = 0
		npcHandler:resetNpc()
		return true
	else
		if talkState[talkUser] ~= nil then
			if talkState[talkUser] > 0 then
			npcHandler:say('Come back when you get these items.', cid)
			rtnt[talkUser] = nil
			talkState[talkUser] = 0
			npcHandler:resetNpc()
			return true
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())