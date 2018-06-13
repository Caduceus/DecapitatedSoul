-- revive system by zbizu
-- config
	local deathStorage = 250120
	local counterStorage = 250121 -- res expiration timestamp
	local deathGroupId = 0
	local reviveStone = 12411 -- cultish symbol
	local resTime = 5 * 60 -- 5 minutes
	local showCountdown = true -- shows timer above dead player
	local arena = {
    frompos = {x = 1061, y = 958, z = 15},
	topos = {x = 1077, y = 966, z = 15},
	exitpos = {x = 1060, y = 963, z = 14}
}
-- end of config

local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(-1)

function Player:setHealth(value)
	if not self:isPlayer() then return false end
	self:addHealth(value - self:getHealth())
return true
end

function Player:setMana(value)
	if not self:isPlayer() then return false end
	self:addMana(value - self:getMana(), false)
return true
end


function buildModalWindow(cid)
	local player = Player(cid)
	local resitem = player:getItemCount(reviveStone)
	
	local modal = ModalWindow(999, "You are dead", "Alas! Brave adventurer, you have met a sad fate.\nBut do not despair, for the gods will bring you back\ninto the world in exchange for a small sacrifice. " .. (resitem > 0 and "\n\n" .. ItemType(reviveStone):getName() .. " x" .. resitem or "") .. "\n\nIf you choose to die, logout or your time run\nout, death penatly will be applied.")

	modal:addButton(1, "Die")
	modal:setDefaultEnterButton(1)
	modal:addButton(2, "Wait")
	modal:setDefaultEscapeButton(2)

	if resitem > 0 then
		modal:addButton(3, "Use Item")
	end

	return modal:sendToPlayer(player)
end

function Player:isDead()
	return self:getGroup():getId() == deathGroupId
end

function Player:die()
	self:toggleDeath()
	self:setStorageValue(counterStorage, -1)
	self:setStorageValue(deathStorage, 1)
	self:addHealth(-(self:getMaxHealth()))
	return true
end

function sendDeathWindowOnMove(cid, lockPos)
	local player = Player(cid)
	if not player then return false end
	if not player:isDead() then
		return false
	end
	
	if os.time() > player:getStorageValue(counterStorage) then
		player:die()
		return true
	end
	
	player:setHealth(100)
	addEvent(sendDeathWindowOnMove, 100, cid, lockPos)
	
	if player:getPosition() ~= lockPos then
		player:teleportTo(lockPos)
		buildModalWindow(cid)
	end
	
	return true
end

function sendReviveCountdown(cid)
	if not showCountdown then return false end
	local player = Player(cid)
	if not player then return false end
	if not player:isDead() then
		return false
	end
	
	local timeleft = os.date("!%X",player:getStorageValue(counterStorage) - os.time()):split(":")
	
	
	player:say(timeleft[2] .. ":" .. timeleft[3], TALKTYPE_MONSTER_SAY)
	addEvent(sendReviveCountdown, 1000, cid)
	return true
end

function Player:toggleDeath(countdown)
	if self:isDead() then
		self:setGroup(Group(1))
		self:setHiddenHealth(false)
		self:setHealth(math.ceil(self:getMaxHealth() * 0.5))
		self:setMana(math.ceil(self:getMaxMana() * 0.5))
		self:removeCondition(CONDITION_OUTFIT)
		return true
	end
	
	if countdown then
		self:setStorageValue(counterStorage, os.time() + countdown)
	end
	
	self:setHealth(100)
	self:setGroup(Group(deathGroupId))
	self:setHiddenHealth(true)
	buildModalWindow(self:getId())
	sendDeathWindowOnMove(self:getId(), self:getPosition())
	sendReviveCountdown(self:getId())
	return true
end

function onLogin(player)
	player:registerEvent("modalDeath")
	player:registerEvent("deathMW")
	player:registerEvent("loginDeath")

	if player:isDead() then
		if player:getStorageValue(counterStorage) == -1 then
			player:toggleDeath()
			return true
		end
		
		if os.time() > player:getStorageValue(counterStorage) then
			player:die()
			return true
		end
		
		player:setHiddenHealth(true)
		sendDeathWindowOnMove(player:getId(), player:getPosition())
		sendReviveCountdown(player:getId())
	end

	return true
end

function onPrepareDeath(creature, killer)
-- not sure if counts kill on pvp
	if not creature:isPlayer() then
	if not getCreaturesInQuestArea(TYPE_PLAYER, arena.frompos, arena.topos, GET_COUNT) == 1 then
		return true
	end
end
	
	if creature:getStorageValue(deathStorage) == 1 then
		creature:setStorageValue(deathStorage, -1)
		return true
	end
	
	creature:toggleDeath(resTime)
	condition:setOutfit(creature:getSex() == PLAYERSEX_FEMALE and 3065 or 3058)
	creature:addCondition(condition)
	return false
end

function onModalWindow(player, modalWindowId, buttonId, choiceId)
	if modalWindowId ~= 999 then
		return false
	end
	
	if not player:isDead() then
		return false
	end
	
	if buttonId == 1 then
		player:die()
		return true
	elseif buttonId == 2 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You decided to wait for a healer. Move in any direction to send revival window again.")
		return true
	elseif buttonId == 3 then
		if player:getItemCount(reviveStone) == 0 then
			player:sendCancelMessage("You don't have any item to revive yourself.")
			return true
		end
		
		player:getItemById(reviveStone, true):remove(1)
		player:toggleDeath()
		local revst = ItemType(reviveStone)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You revived yourself with " .. revst:getArticle() .. " " .. revst:getName() .. ".")
	end
	return true
end