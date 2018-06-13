local config = {
    savePlayersOnAdvance = true
}

function onAdvance(player, skill, oldLevel, newLevel)
    if(config.savePlayersOnAdvance) then
        player:save()
        player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
        player:getPosition():sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
    end
    return true
end
