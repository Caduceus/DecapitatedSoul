function onThink(creature)

local starveDamage = creature:getMaxHealth() / 200

local function setStarve(self)
	creature:addHealth(-starveDamage)
end

local condition = creature:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition == nil then
		return true
	end
	if creature:getAccountId() ~= 1 or creature:getAccountId() ~= 2 then
		return true
	end
	if condition:getTicks() / 1000 < 500 then
		setStarve()
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		creature:sendTextMessage(MESSAGE_STATUS_SMALL, "You are Starving!")
	end
	return true
end
