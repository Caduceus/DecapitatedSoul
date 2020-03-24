function onSay(player, words, param)
local playerId = player:getGuidByStorage(serverRecord.dps)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Your Personal Best DPS: " .. player:getStorageValue(serverRecord.playerRecordDps) .. " | Server Record: " .. getPlayerNameById(playerId) .. ": " .. player:getServerRecord(serverRecord.dps) .. "")
    return false
end