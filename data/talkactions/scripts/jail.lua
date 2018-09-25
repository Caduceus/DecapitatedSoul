local config = {
    -- List of players that cannot be jailed
    blacklist = {'Dev. Caduceus', 'Pantiecakes', 'pew pew pew'},
    -- if true you can even jail other GMs :)
    canJailAccess = true,

    -- if true it will not show the name of the Staff member that used the command
    anonymous = false,

    -- Position of your jail
    jailPosition = Position(1023, 954, 6),

    -- if unjailToTemple is set to true it will teleport the player to their hometown
    -- otherwise it will use unjailPosition
    unjailToTemple = false,
    unjailPosition = Position(1021, 955, 6)
}


function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end  
    
    local targetPlayer = Player(param)
    if not targetPlayer then
        player:sendCancelMessage('Usage: ' .. words .. ' <playername>')
        return false
    end
    
    local action = string.sub(words, 2, #words) .. '' --self
    
    if targetPlayer:getName() == player:getName() then
		player:sendCancelMessage('You cannot ' .. action .. ' yourself.')
		return false
	end
    
    if targetPlayer:getAccountId() == 1 then
		player:sendCancelMessage('You cannot ' .. action .. ' ' .. targetPlayer:getName() .. '.')
		player:sendCancelMessage('' .. player:getName() .. ' tried to ' .. action .. ' you.')
		return false
	end
    
    if not config.canJailAccess and targetPlayer:getGroup():getAccess() then
        player:sendCancelMessage('You cannot jail/unjail this player.')
        return false
    end
        
    local toPosition
    if words == '/jail' then
        toPosition = config.jailPosition
        targetPlayer:setTown(Town(14))
    elseif words == '/unjail' then
        if config.unjailToTemple then
            toPosition = targetPlayer:getTown():getTemplePosition()
        else
            toPosition = config.unjailPosition
            targetPlayer:setTown(Town(1))
        end
    end
    
    local action = string.sub(words, 2, #words) .. 'ed'
    player:sendCancelMessage('You have ' .. action .. ' ' .. targetPlayer:getName() .. '.')
    targetPlayer:sendCancelMessage('You have been ' .. action .. (config.anonymous and '' or ' by ' .. player:getName()) .. '.')
    targetPlayer:teleportTo(toPosition)
    toPosition:sendMagicEffect(CONST_ME_TELEPORT)
    return false
end