function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    if player:getStorageValue(1233) >= os.time() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "This item does not stack with a Winning Lottery Ticket!")
		return true
	end
	
    if player:getStorageValue(1234) >= os.time() then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You many not use this item yet!")
        return true
    end

	Combat():setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
 
	--set an icon to player for 2 hours
	local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_SUBID, 2)
		condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
		condition:setParameter(CONDITION_PARAM_TICKS, 3600000)
		player:addCondition(condition)

		player:setStorageValue(1234, os.time() + 3600)
		Item(item.uid):remove(1)
		player:say('I\'m on Fire!', TALKTYPE_MONSTER_SAY)
		player:registerEvent('ExpScrollTimer')
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Your 1 hour of double XP has started!")
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your 1 hour of double XP has started!")
		
        return true
end

function Player:onGainExperience(source, exp, rawExp)
    if self:getStorageValue(1234) >= os.time() then
        exp = exp * 2
    end
    return exp
end