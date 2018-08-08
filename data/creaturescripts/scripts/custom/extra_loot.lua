local extra_loot = {
	{hasName = "dragon lord", items = {
		{id = 5948, count = 2, chance = 50000}, -- 50% red leather
		{id = 2160, countMax = 4, chance = 1000} --100% cc
	}},
	{items = {
		--{id = 18422, countMax = 1, chance = 1000} -- 1% daily token
	}},
}

function Container:addExtraLoot(c, t)
	if t.hasName then
		local cn = c:getName():lower()
		local cm = t.hasName:lower()
		if not cn:match(cm) then
			return true
		end
	end
	
	for i = 1, #t.items do
		local count = 1
		if t.items[i].count then
			if t.items[i].countMax then
				count = math.random(t.items[i].count, t.items[i].countMax)
			else
				count = t.items[i].count
			end
		else
			if t.items[i].countMax then
				count = math.random(1, t.items[i].countMax)
			end
		end
		
		--local player = Player(cid)
		if math.random(0, 100000) <= t.items[i].chance then
			self:addItem(t.items[i].id, count)
			--player:say('bonus loot', TALKTYPE_MONSTER_SAY)
		end
	end
end

function onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature:isMonster() then return true end
	if corpse and corpse:isContainer() then
		for i = 1, #extra_loot do
			corpse:addExtraLoot(creature, extra_loot[i])
		end
	end
	return true
end
