function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local desc = item:hasAttribute('description') and item:getAttribute('description')
    if not desc:find(player:getName():lower()) then
        player:say('You cannot use this teleport.', TALKTYPE_MONSTER_SAY, false, 0, fromPosition)
        player:teleportTo(fromPosition)
        fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
        position:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    local storages, s = {82001, 82002, 82003}, {}
    for i = 1, 3 do
        s[#s + 1] = player:getStorageValue(storages[i])
    end

    local teleportDestination = Position(s[1], s[2], s[3])
    player:teleportTo(teleportDestination)
    position:sendMagicEffect(CONST_ME_TELEPORT)
    teleportDestination:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end