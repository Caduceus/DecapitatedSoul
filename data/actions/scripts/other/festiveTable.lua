local TABLES = {
	[33928] = {0, "Nom Nom Nom"}, -- table uneaten
	[33929] = {0, "Munch"}, -- table 
	[33930] = {0, "Awww"}, -- table scraps
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local food = TABLES[item.itemid]
	if food == nil then
		return false
	end
	if item:getId() == 33930 then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "There is nothing left to eat.")
		return true
	end
	local itemId = item:getId()
	local condition = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition == nil then
		player:feed(1)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Your current nutrition is " .. condition:getTicks() / 1000 .. "/1500.")
		--item:transform(itemId + 1)
		return true
	end
	if condition and math.floor(condition:getTicks() / 1000 + food[1]) > 1500 then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Your current nutrition is " .. condition:getTicks() / 1000 .. "/1500. You are full.")
	else
		player:feed(1500)
		player:say(food[2], TALKTYPE_MONSTER_SAY)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Your current nutrition is " .. condition:getTicks() / 1000 .. "/1500.")
		item:transform(itemId + 1)
	end
	return true
end
