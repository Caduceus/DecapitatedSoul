function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    if player:getStorageValue(1234) >= os.time() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "This item does not stack with a Double Experience Grant!")
        return true
    end
		
	if player:getStorageValue(1233) >= os.time() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You many not use this item yet!")
		return true
	end

	Combat():setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
 
	
	local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_SUBID, 2)
		condition:setParameter(CONDITION_PARAM_BUFF_SPELL, 1)
		condition:setParameter(CONDITION_PARAM_TICKS, 1800000) --set an icon to player for 30 minutes
		player:addCondition(condition)

		player:setStorageValue(1233, os.time() + 1800)
		Item(item.uid):remove(1)
		player:say('Whew!', TALKTYPE_MONSTER_SAY)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Your 30 minutes of double XP has started!")
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your 30 minutes of double XP has started! This effect does not last through death.")
		
        return true
end

function Player:onGainExperience(source, exp, rawExp)
    if self:getStorageValue(1233) >= os.time() then
        exp = exp * 2
    end
    return exp
end
