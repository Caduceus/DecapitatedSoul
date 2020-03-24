function onThink(creature)

local starveDamage = creature:getMaxHealth() / 100

local function setStarve(self)
	creature:addHealth(-starveDamage)
end

local condition = creature:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition == nil then
		return true
	end
	if condition:getTicks() / 1000 < 500 and creature:getAccountId() ~= 1 then
		setStarve()
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		creature:sendTextMessage(MESSAGE_STATUS_SMALL, "You are Starving!")
	end
	return true
end
