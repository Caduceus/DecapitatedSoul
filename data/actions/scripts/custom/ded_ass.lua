local maleDestination = Position(1037, 952, 8)
local femaleDestination = Position(1037, 953, 8)

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if isInArray({3058, 3059}, target.itemid) then
		target:moveTo(maleDestination, false)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Male Corpse sent to storage.")
		player:getPosition():sendMagicEffect(CONST_ME_BLUE_STATIC)
    return true
    elseif isInArray({3065, 3066}, target.itemid) then
		target:moveTo(femaleDestination, false)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Female Corpse sent to storage.")
		player:getPosition():sendMagicEffect(CONST_ME_RED_STATIC)
	return true
    end
end
