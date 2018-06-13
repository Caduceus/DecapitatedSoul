local vipItems = {
   -- [itemid] = amount of vip days
    [10135] = 1,
    [10134] = 5,
    [10133] = 10
}

function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
    local player = Player(cid)
    local days = vipItems[item.itemid]
    player:addVipDays(days)
    player:say('!* VIP *!', TALKTYPE_MONSTER_SAY)
    player:getPosition():sendMagicEffect(CONST_ME_STUN)
    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('You received %s vip days.', days))
    Item(item.uid):remove(1)
    return true
end
