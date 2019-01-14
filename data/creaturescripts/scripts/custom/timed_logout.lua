function onLogout(player)
    if player:getStorageValue(111111) <= os.time() then
        player:setStorageValue(111111, os.time() + 10) -- 10 seconds
    else
        player:sendCancelMessage("Please wait ten seconds to logout.")
        return false
    end
    return true
end
