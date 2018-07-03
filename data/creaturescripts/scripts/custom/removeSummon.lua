function onThink(creature)
if creature:getSummons() == false then
	return false
end
	
local pos = creature:getPosition()
    if getTilePzInfo(pos) == true and #creature:getSummons() >= 1 then
        creature:doRemoveSummon()
        creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your summon has vanished due to protection zone")
    return true
	end
end
