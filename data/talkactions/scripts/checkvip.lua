function onSay(cid, words, param)
    local player = Player(cid)

    local days = player:getVipDays()
    if days == 0 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You do not have any vip days.")
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,(string.format('You have %s vip day%s left.', (days == 0xFFFF and 'infinite amount of' or days), (days == 1 and '' or 's'))))
    end
    return false
end