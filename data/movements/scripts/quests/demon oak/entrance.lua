local config = { 
		AxeBlowsBird = 8288,
		AxeBlowsLeft = 8289,
		AxeBlowsRight = 8290,
		AxeBlowsFace = 8291
	}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local specs, spec = Game.getSpectators(DEMON_OAK_POSITION, false, false, 9, 9, 6, 6)
        for i = 1, #specs do
            spec = specs[i]
            if spec:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "A player is already inside.")
                return true
            end
			
            spec:remove()
        end

	--[[if player:getStorageValue(Storage.DemonOak.Done) >= 1 then
		player:teleportTo(DEMON_OAK_KICK_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end]]
	if player:getStorageValue(Storage.DemonOak.Squares) == 5 and player:getStorageValue(Storage.DemonOak.Done) == 3 and #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
		player:setStorageValue(config.AxeBlowsBird, -1)
		player:setStorageValue(config.AxeBlowsLeft, -1)
		player:setStorageValue(config.AxeBlowsRight, -1)
		player:setStorageValue(config.AxeBlowsFace, -1)
		player:teleportTo(DEMON_OAK_ENTER_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Didn't get enough the first time?!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
		return true
	end


	if player:getStorageValue(Storage.DemonOak.Squares) == 5 and #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
		player:setStorageValue(config.AxeBlowsBird, -1)
		player:setStorageValue(config.AxeBlowsLeft, -1)
		player:setStorageValue(config.AxeBlowsRight, -1)
		player:setStorageValue(config.AxeBlowsFace, -1)
		player:teleportTo(DEMON_OAK_ENTER_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setStorageValue(Storage.DemonOak.Progress, 1)
		player:say("I AWAITED YOU! COME HERE AND GET YOUR REWARD!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
	else
		player:teleportTo(DEMON_OAK_KICK_POSITION)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
