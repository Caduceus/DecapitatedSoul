function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    for i = 1, 5 do
        if player:hasBlessing(i) then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have full blessings.")
            return true
        end

        player:addBlessing(i)
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by the gods.")
    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    item:remove(1)
    return true
end
