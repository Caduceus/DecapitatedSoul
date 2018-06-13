function onSay(cid, words, param)
local player = Player(cid)
    if not player then
        return true
    end
    if player:removeMoneyNpc(cid,25000) == 1 then
        doPlayerAddItem(cid,2173,1)
        doSendMagicEffect(getPlayerPosition(cid),12)
        doPlayerSendTextMessage(cid,22,"You've bought an Amulet of Loss!")
    else
        doPlayerSendCancel(cid,"You don't have enough money.")
        doSendMagicEffect(getPlayerPosition(cid),2)
    end

    return true
end