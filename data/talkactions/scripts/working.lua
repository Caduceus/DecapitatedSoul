function repeatMessage(id)
    local p = Player(id)
    if p then
        if p:getStorageValue(afkactive) == 1 then
            p:say('I am hard at work!', TALKTYPE_MONSTER_SAY)
            addEvent(repeatMessage, 8 * 1000, id) -- 1000 = 1 second
        end
    end
    return true
end

function onSay(player, words, param)
if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
    if param == "on" then
        player:setStorageValue(afkactive, 1)
        repeatMessage(player:getId())
    elseif param == "off" then
        player:setStorageValue(afkactive, 0)
    end
    return false
end