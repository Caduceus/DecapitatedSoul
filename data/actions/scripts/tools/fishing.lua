local waterIds = {493, 4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 7236, 10499, 15401, 15402}
local lootTrash = {2240, 2234, 2238, 2667, 2667, 2667}
local lootCommon = {2167, 2168, 2669}
local lootRare = {7158, 10224, 7159}
local lootVeryRare = {7632, 7633, 10220}
local useWorms = true

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target.itemid
	if not isInArray(waterIds, target.itemid) then
		return false
	end
	
	local pos = player:getPosition()
	if getTilePzInfo(pos) == true then 
		player:say('You cannot fish in a protection zone.', TALKTYPE_MONSTER_SAY)
	return false
    end

	if targetId == 10499 then
		local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
		if owner ~= 0 and owner ~= player:getId() then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are not the owner.")
			return true
		end

		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		target:remove()

		local rareChance = math.random(1, 100)
		if rareChance == 1 then
			player:addItem(lootVeryRare[math.random(#lootVeryRare)], 1)
		elseif rareChance <= 3 then
			player:addItem(lootRare[math.random(#lootRare)], 1)
		elseif rareChance <= 10 then
			player:addItem(lootCommon[math.random(#lootCommon)], 1)
		else
			player:addItem(lootTrash[math.random(#lootTrash)], 1)
		end
		return true
	end

	if targetId ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end

	if targetId == 493 or targetId == 15402 then
		return true
	end

	player:addSkillTries(SKILL_FISHING, 1)
	if math.random(1, 100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
		if useWorms and not player:removeItem("worm", 1) then
			return true
		end

		if targetId == 15401 then
			target:transform(targetId + 1)
			target:decay()

			if math.random(1, 100) >= 97 then
				player:addItem(15405, 1)
				return true
			end
		elseif targetId == 7236 then
			target:transform(targetId + 1)
			target:decay()

			local rareChance = math.random(1, 100)
			if rareChance == 1 then
				player:addItem(7158, 1)
				return true
			elseif rareChance <= 4 then
				player:addItem(2669, 1)
				return true
			elseif rareChance <= 10 then
				player:addItem(7159, 1)
				return true
			end
		end

		--increase chance of catching
		--[[if item.itemid == 2580 then
               special_chance = player_skill*0.5
           elseif item.itemid == 10223 then
               special_chance = player_skill*0.3
           end]]
           --if math.random(1, 100) <= special_chance then




		local monsters = {
			"Crab",
			"Tortoise",
			"Blood Crab",
			"Jellyfish",
		}
		
		if isInArray(waterIds, target.itemid) then
			
		local rareChance = math.random(1, 100)
		local pos = player:getPosition()
		if rareChance == 1 then
			player:addItem(lootVeryRare[math.random(#lootVeryRare)], 1)
		elseif rareChance <= 3 then
			player:addItem(lootRare[math.random(#lootRare)], 1)
		elseif rareChance <= 10 then
			player:addItem(lootCommon[math.random(#lootCommon)], 1)
		elseif rareChance >= 95 then
			Game.createMonster(monsters[math.random(#monsters)], player:getPosition())
		else
			player:addItem(lootTrash[math.random(#lootTrash)], 1)
		end
		return true
		end
	end
	return true
end
