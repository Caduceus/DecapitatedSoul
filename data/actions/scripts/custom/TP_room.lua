local Position = Position(1003, 957, 15)

function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end

    if item.actionid == 15001 then
        if player:getStorageValue(15001) == 0 then
            player:teleportTo(fromPosition)
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            player:sendCancelMessage('You Must Complete Catacombs Quest to Gain Access To This Teleport.')
        end
    elseif item.actionid == 15001 then
        if player:getStorageValue(15001) == 1 then
            player:teleportTo(Position)
            Position:sendMagicEffect(CONST_ME_STUN)
    end
    return true
	end
end