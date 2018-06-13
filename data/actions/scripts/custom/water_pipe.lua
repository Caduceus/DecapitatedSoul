local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 30000)

local config = {
		amount = 100, 
		time = 3, 
	  exhaust = {
		storage = 1000,
		time = 3, 
	}
}

local function doRegeneration(cid, amount, seconds)
if seconds <= 0 then
return false
end
--doTargetCombatMana(cid, amount)

--doSendMagicEffect(getThingPos(cid), 25)
return addEvent(doRegeneration, 1000, cid, amount, seconds - 1)
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
if player:getExhaustion(1000) > 0 then
	return player:sendCancelMessage("Chill.. Pothead..")
end
if player:getItemCount(5953) > 0 then
	player:removeItem(5953, 1)
	player:addCondition(drunk)
	player:say('That was strong shit.', TALKTYPE_MONSTER_SAY)
	player:setExhaustion(1000, 10)
else
player:sendCancelMessage("You need marijuana for this.")
end
return true
end
