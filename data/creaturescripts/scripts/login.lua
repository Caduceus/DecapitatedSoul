function onLogin(player)
local aurastr = 25950 -- storage of aura
local estr = 25951 -- storage for exhaust
setPlayerStorageValue(player, aurastr, -1)
setPlayerStorageValue(player, estr, -1)
	--local loginStr = "Welcome to " .. configManager.getString(configKeys.SERVER_NAME) .. " 10.9!"
	local loginStr = "Thank you for playing on " .. configManager.getString(configKeys.SERVER_NAME) .. ", " .. player:getName() .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
		else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, loginStr)
			player:loadVipData()
			player:updateVipTime()
			player:setStorageValue(9999, player:getVipDays())
		end
		
		loginStr = string.format("Your last visit was on %s.", os.date("%a %b %d %Y %X", player:getLastLoginSaved()))
		player:getPosition():sendMagicEffect(CONST_ME_THUNDER)
		player:openChannel(3)
		player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
	end
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, loginStr)
	
	 -- Free bless
    local freeBless = {
        level = 79,
        blesses = {1, 2, 3, 4, 5}
    }

    if player:getLevel() <= freeBless.level then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You have free Blessings.")
        for i=1, #freeBless.blesses do
            player:addBlessing(freeBless.blesses[i])
        end
    end
    
    if player:getLevel() > freeBless.level and player:hasBlessing(5) then
			player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You are Blessed.")
    elseif not isPlayer or not player:hasBlessing(5) then
			player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You do not have Blessings!")
		end

	-- Stamina
	nextUseStaminaTime[player.uid] = 0
	
	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(STORAGEVALUE_PROMOTION)
		if not promotion and value ~= 1 then
			player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
		elseif value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end
	
	-- Rewards notice
	local rewards = #player:getRewardList()
	if rewards > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You have %s %s in your reward chest.", rewards == 1 and 'one' or rewards, rewards > 1 and "rewards" or "reward"))
	end

	-- Update player id 
	local stats = player:inBossFight()
	if stats then
		stats.playerId = player:getId()
	end
	
	local lastLogout = player:getLastLogout()
	local offlineTime = lastLogout ~= 0 and math.min(os.time() - lastLogout, 86400 * 21) or 0
	local time = 1*60*60 -- 1s*60s = 60s * 60s = 60min
	if player:getAccountId() == 1 or player:getAccountId() == 2 then
		player:setStorageValue(455577, -1)
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "[Admin Account]: Your current coin balance is ".. player:getCoinsBalance() ..".")
	elseif offlineTime < 300 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your coin timer did not reset! Try !coin to see your time remaining.")
		return true
	else
		player:setStorageValue(455577, os.time() + time)
		player:save()
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "For every 1 hour online, you will receive 1 coin to use in the store. Your current coin balance is ".. player:getCoinsBalance() ..".")
	end
	
	-- Events
	player:registerEvent("addPointTimer")
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("Missions")
	player:registerEvent("Tasks")
	player:registerEvent("CreateTeleport")
	player:registerEvent("SoulRegen")
	player:registerEvent("MastersVoiceServants")
	player:registerEvent("onadvance_reward")
	player:registerEvent("AoD_Servants")
	player:registerEvent("modalAD")
	player:registerEvent("modalMD")
	--player:registerEvent("RewardLoot")
	player:registerEvent("creature_advance")
	player:registerEvent("PlayerPromo")
	player:registerEvent("MapStorage")
	player:registerEvent("BossParticipation")
	player:registerEvent("AutoLoot")
	player:registerEvent("sistersDeath")
	player:registerEvent("medusaDeath")
	player:registerEvent("hookDeath")
	player:registerEvent("LBQDeath")
	player:registerEvent("stormblastDeath")
	player:registerEvent("ThievesGuildNomad")
	player:registerEvent("returnPromo")
	player:registerEvent("removeSummon")
	player:registerEvent("chestTimer")
	player:registerEvent("lightBearer")
	player:setStorageValue(MAY_NOT_MOVE, -1)
	player:setOutfit(player:getOutfit())
	print("" .. os.date("%H:%M:%S") .. " - " .. player:getName() .. " logged in.")
	return true
end
