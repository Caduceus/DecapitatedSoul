function onDeath(player, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
local necklace = player:getSlotItem(CONST_SLOT_NECKLACE)
    if necklace == 2354 and player:isDead() then
		player:teleportTo(player:getTown():getTemplePosition())
        player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Restore!!")
        player:removeItem(2354, 1)
        player:getPosition():sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
        return true
    end
    return false
end

function onLogin(player)
	player:registerEvent("prevent_death_amulet")
	return true
end