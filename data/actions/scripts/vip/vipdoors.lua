local vipPosition = Position(101, 116, 7)

function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
    local player = Player(cid)
    if item.actionid == 1502 then
        local position = player:getPosition()
        if position.y < fromPosition.y then
            fromPosition.y = fromPosition.y + 1
        else
            fromPosition.y = fromPosition.y - 1
        end
        player:teleportTo(fromPosition)
        player:say('!* VIP *!', TALKTYPE_MONSTER_SAY)
        fromPosition:sendMagicEffect(CONST_ME_STUN)

    elseif item.actionid == 1503 then
        local position = player:getPosition()
        if position.x < fromPosition.x then
            fromPosition.x = fromPosition.x + 1
        else
            fromPosition.x = fromPosition.x - 1
        end
        player:teleportTo(fromPosition)
        player:say('!* VIP *!', TALKTYPE_MONSTER_SAY)
        fromPosition:sendMagicEffect(CONST_ME_STUN)

    elseif item.actionid == 1504 then
        if player:isVip() then
            player:teleportTo(vipPosition)
            player:say('!* VIP *!', TALKTYPE_MONSTER_SAY)
            vipPosition:sendMagicEffect(CONST_ME_STUN)
        else
            player:sendCancelMessage('You do not have vip.')
        end
    end
    return true
end