function onUse(cid, item, fromPosition, itemEx, toPosition, isHotkey)
    local p = Player(cid)
    local prizes = {5958, 18422, 5958, 2798, 5957}
    if math.random(100) <= 30 then
        p:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
        p:sendTextMessage(MESSAGE_INFO_DESCR, "Congratulations! You won a prize!")
        p:addItem(prizes[1])
        if math.random(100) <= 15 then
            p:addItem(prizes[2])
        end
        Item(item["uid"]):remove()
    else
        p:getPosition():sendMagicEffect(CONST_ME_POFF)
        p:sendTextMessage(MESSAGE_INFO_DESCR, "Sorry, but you drew a blank. Better luck next time.")
        Item(item["uid"]):remove()
    end
    return true
end
