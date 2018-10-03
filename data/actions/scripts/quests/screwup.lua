function onUse(player, item, fromPosition, target, toPosition, isHotkey)
        player:addOutfitAddon(1102, 3)
        player:addMount(2)
        player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Thanks for playing on Decapitated Soul, " .. player:getName() .."! ~ Caduceus")
		item:remove(1)
    return true
end
