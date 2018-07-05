function onThink(creature)
local hp = creature:getMaster():getMaxHealth()
local speed = creature:getMaster():getBaseSpeed()
	if hp > creature:getMaxHealth() then
		creature:setMaxHealth(hp)
		creature:addHealth(hp)
		creature:changeSpeed(speed)
	end
end
