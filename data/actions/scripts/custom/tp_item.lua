local pos = {x = 873, y = 873, z = 5}
function onUse(player, item, fromPosition, itemEx, toPosition)
    if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:say('You cant teleport whilst in battle!', TALKTYPE_MONSTER_SAY)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end

    --player:teleportTo(player:getTown():getTemplePosition())
    player:teleportTo(pos)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    return true
end