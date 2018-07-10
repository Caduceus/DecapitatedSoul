local vocs = {
    nonPromoted = {1, 2, 3, 4, 9},
    promoted = { 11, 12, 13, 14, 15},
    setPromotion = {
        [5] = 11,
        [6] = 12,
        [7] = 13,
        [8] = 14,
        [10] = 15
    }
}
function onUse(player, item, fromPosition, target, toPosition)
	local vocName = player:getVocation():getBase():getName()
    local vocId = player:getVocation():getId()
    if player:getLevel() < 400 then
        return player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to be level 400 or higher to use this!") and false
    end
 
    if isInArray(vocs.promoted, vocId) then
        return player:sendTextMessage(MESSAGE_INFO_DESCR, "You have already got your second promotion!") and false
    elseif isInArray(vocs.nonPromoted, vocId) then
        return player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to get your first promotion before using this!") and false
    end
 
    player:setVocation(vocs.setPromotion[vocId])
    item:remove(1)
    player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You were promoted to a Warlord " ..vocName.. "!")
    player:save()
    return true
end
