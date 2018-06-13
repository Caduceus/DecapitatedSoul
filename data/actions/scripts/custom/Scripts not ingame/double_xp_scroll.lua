function onUse(cid, item, fromPosition, itemEx, toPosition)
    local player = Player(cid)
    if player:getStorageValue(1234) >= os.time() then
        player:say('You already have double exp!', TALKTYPE_MONSTER_SAY)
        return true
    end

    player:setStorageValue(1234, os.time() + 86400)
    Item(item.uid):remove(1)
    player:say('Your 24 hours of double XP has started!', TALKTYPE_MONSTER_SAY)
    return true
end

function Player:onGainExperience(source, exp, rawExp)
    if self:getStorageValue(1234) >= os.time() then
        exp = exp * 2
    end
    return exp
end