local vipPosition = Position(101, 116, 7)

function onStepIn(cid, item, position, fromPosition)
    local player = Player(cid)
    if not player then
        return true
    end

    if item.actionid == 1500 then
        if not player:isVip() then
            player:teleportTo(fromPosition)
            fromPosition:sendMagicEffect(CONST_ME_POFF)
            player:sendCancelMessage('You do not have a vip account.')
        end
    elseif item.actionid == 1501 then
        if player:isVip() then
            player:teleportTo(vipPosition)
            player:say('!* VIP *!', TALKTYPE_MONSTER_SAY)
            vipPosition:sendMagicEffect(CONST_ME_STUN)
        else
            player:teleportTo(fromPosition)
            player:sendCancelMessage('You do not have vip account.')
            fromPosition:sendMagicEffect(CONST_ME_POFF)
        end
    end
    return true
end

--[[ 
-There are 2 versions of vip tiles.
ActionId 1500 will not let players without vip days pass.
- You can use these in a path where only vip player should be able to go through.
ActionId 1501 will not let players without vip days enter, while it will teleport vip players to a defined position.
- You can use these as the entrance to a vip-only area for example. 

-- Note! You must edit Position(101, 116, 7) to your vip area position if using actionid 1501
]]