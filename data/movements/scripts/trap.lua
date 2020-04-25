function onStepIn(creature, item, position, fromPosition)

	if creature:isMonster() then
		return 
	end

	if Tile(position):hasFlag(TILESTATE_PROTECTIONZONE) then
		return false
	end

local min = creature:getMaxHealth() / 20
local max = creature:getMaxHealth() / 10
local traps = {
	[1510] = {transformTo = 1511, damage = {-min, -max}},
	[1512] = {transformTo = 1513, damage = {-min, -max}},
	[2579] = {transformTo = 2578, damage = {-min, -max}, ignorePlayer = false},
	[4208] = {transformTo = 4209, damage = {-min, -max}, type = COMBAT_EARTHDAMAGE}
}
	local trap = traps[item.itemid]
	if not trap then
		return true
	end

	if trap.transformTo then
		item:transform(trap.transformTo)
	end

	if trap.ignorePlayer and creature:isPlayer() then
		return true
	end

	doTargetCombatHealth(0, creature, trap.type or COMBAT_PHYSICALDAMAGE, trap.damage[1], trap.damage[2], CONST_ME_NONE)
	return true
end

function onStepOut(creature, item, position, fromPosition)
	item:transform(item.itemid - 1)
	return true
end

function onRemoveItem(item, tile, position)
	local thingPos = item:getPosition()
	if thingPos:getDistance(position) > 0 then
		item:transform(item.itemid - 1)
		thingPos:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
