function onEquip(player, item, slot)
if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:sendTextMessage(MESSAGE_STATUS_WARNING,"You cannot equip this item while in battle!")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
		player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	return true
end
