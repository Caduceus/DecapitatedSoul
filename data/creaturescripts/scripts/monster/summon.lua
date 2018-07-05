function onThink(creature)
local master = creature:getMaster()
	if master == nil then
	return false
end
local hp = creature:getMaster():getMaxHealth()
local speed = creature:getMaster():getBaseSpeed()
	if hp > creature:getMaxHealth() then
		creature:setMaxHealth(hp)
		creature:addHealth(hp)
		creature:changeSpeed(speed)
	end
end
