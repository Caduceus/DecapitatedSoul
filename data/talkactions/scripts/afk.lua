function repeatAfk(id)
    local p = Player(id)
    if p then
        if p:getStorageValue(afkactive) == 1 then
            p:say('AFK', TALKTYPE_MONSTER_SAY)
            addEvent(repeatAfk, 5 * 1000, id) -- 1000 = 1 second
        end
    end
    return true
end

function onSay(player, words, param)
    if param == "on" then
        player:setStorageValue(afkactive, 1)
        repeatAfk(player:getId())
    elseif param == "off" then
        player:setStorageValue(afkactive, 0)
    end
    return false
end