local deathGroupId = 0
function Player:isDead()
	return self:getGroup():getId() == deathGroupId
end

function onCastSpell(creature, var, isHotkey)
	local position = creature:getPosition()
	local manaCost = math.ceil(creature:getMaxMana() * 0.3)
	if creature:getMana() < manaCost then
		creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local target = Player(variantToNumber(var))
	if not target then
		creature:sendCancelMessage("Incorrect target.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	if creature:getPosition():isSightClear(target:getPosition()) then
		if target:isDead() then
			creature:addMana(-manaCost, false)
			creature:addManaSpent(manaCost)
			
			target:setGroup(Group(1))
			target:setHiddenHealth(false)
			
			target:addMana(math.ceil(target:getMaxMana() * 0.3) - target:getMana(), false)
			target:addHealth(math.ceil(target:getMaxHealth() * 0.3) - target:getHealth())
			target:removeCondition(CONDITION_OUTFIT)
			
			target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been resurrected by " .. creature:getName() .. ".")
			return true
		end
		creature:sendCancelMessage("You cannot resurrect this target.")
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	creature:sendCancelMessage("Target unreachable.")
	position:sendMagicEffect(CONST_ME_POFF)
	return false
end