--Functions by Printer
function Player.setExhaustion(self, value, time)
    self:setStorageValue(value, time + os.time())
end
 
function Player.getExhaustion(self, value)
    local storage = self:getStorageValue(value)
    if not storage or storage <= os.time() then
        return 0
    end
 
    return storage - os.time()
end
 
function Player.hasExhaustion(self, value)
    return self:getExhaustion(value) >= os.time() and true or false
end
-- / Functions by Printer
 
local CONFIG = {
    COST = 20000, -- On Gold
    TIME = 2, -- On minutes
    STORAGE = 2552
}
 
function onSay(player, words, param)
    local split = param:split(",")
    if split[1] == nil then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Command param is required.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    if player:removeMoneyNpc(CONFIG.COST) then
        if player:getExhaustion(CONFIG.STORAGE) <= 0 then
            print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
            local players = Game.getPlayers()
            for i = 1, #players do
                players[i]:sendPrivateMessage(player, param, TALKTYPE_BROADCAST)
            end
            player:setExhaustion(CONFIG.STORAGE, CONFIG.TIME * 60)
            return false
        else
            player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You can only send a message each : '.. CONFIG.TIME ..' minutes.')
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    else
        player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You need ' .. CONFIG.COST .. ' gold pieces to broadcast.')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    return false
end