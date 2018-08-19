local ultimateHealthPot = 8473
local MasterSpiritPot = 21245
local MasterHealthPot = 22473
local MasterManaPot = 22472
local greatHealthPot = 7591
local greatManaPot = 7590
local greatSpiritPot = 8472
local strongHealthPot = 7588
local strongManaPot = 7589
local healthPot = 7618
local manaPot = 7620
local smallHealthPot = 8704
local antidotePot = 8474
local greatEmptyPot = 7635
local strongEmptyPot = 7634
local emptyPot = 7636




local antidote = Combat()
antidote:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
antidote:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
antidote:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
antidote:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
antidote:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, (configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL) - 100))
-- 1000 - 100 due to exact condition timing. -100 doesn't hurt us, and players don't have reminding ~50ms exhaustion.

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target == nil or not target:isPlayer() then
		player:addCondition(exhaust)
		player:sendTextMessage(MESSAGE_STATUS_WARNING, "You cannot use a potion on a creature.")
		return false
	end
	
	if player:getCondition(CONDITION_EXHAUST_HEAL) then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
		return true
	end

	local itemId = item:getId()

	if itemId == healthPot then
		local MIN,MAX = target:getMaxHealth() / 8, target:getMaxHealth() / 3.5
			 if not doTargetCombatHealth(0, target.uid, COMBAT_HEALING, MIN, MAX, CONST_ME_MAGIC_BLUE) then
			 return false
		 end

		player:addCondition(exhaust)
		--target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
		item:remove(1)
	elseif itemId == manaPot then
		local Mana_Min,Mana_Max = target:getMaxMana() / 4.3, target:getMaxMana() / 2.2
		if not doTargetCombatMana(0, target.uid, Mana_Min, Mana_Max, CONST_ME_MAGIC_BLUE) then
			return false
		end

		player:addCondition(exhaust)
		--target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
		item:remove(1)
		--player:addItem(emptyPot, 1)
	elseif itemId == greatSpiritPot then
		if (not isInArray({3, 7, 13}, target:getVocation():getId())) and not getPlayerFlagValue(player, PlayerFlag_IgnoreSpellCheck) then
			player:say("This potion can only be consumed by paladins.", TALKTYPE_MONSTER_SAY)
			return true
		end
		
		local MIN_hp,MAX_hp = target:getMaxHealth() / 8, target:getMaxHealth() / 3
		local Min_Mana,Max_Mana = target:getMaxMana() / 4.3, target:getMaxMana() / 2.2
		if not doTargetCombatHealth(0, target.uid, COMBAT_HEALING, MIN_hp, MAX_hp, CONST_ME_HOLYDAMAGE) or not doTargetCombatMana(0, target.uid, Min_Mana, Max_Mana, CONST_ME_YELLOWSMOKE) then
			return false
		end

		player:addCondition(exhaust)
		--target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
		item:remove(1)
		--player:addItem(greatEmptyPot, 1)
	elseif itemId == greatHealthPot then
		--[[if (not isInArray({3, 4, 7, 8}, target:getVocation():getId()) or target:getLevel() < 80) and not getPlayerFlagValue(player, PlayerFlag_IgnoreSpellCheck)  then
			player:say("This potion can only be consumed by knights and paladins of level 80 or higher.", TALKTYPE_MONSTER_SAY)
			return true
		end]]

		local MIN,MAX = target:getMaxHealth() / 10, target:getMaxHealth() / 3.5
			 if not doTargetCombatHealth(0, target.uid, COMBAT_HEALING, MIN, MAX, CONST_ME_MAGIC_BLUE) then
			 return false
		 end

		player:addCondition(exhaust)
		--target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
		item:remove(1)
		--player:addItem(greatEmptyPot, 1)
	elseif itemId == greatManaPot then
		--[[if (not isInArray({1,2,5,6}, target:getVocation():getId()) or target:getLevel() < 225) and not getPlayerFlagValue(player, PlayerFlag_IgnoreSpellCheck) then
			player:say("This potion can only be consumed by sorcerers and druids of level 225 or higher.", TALKTYPE_MONSTER_SAY)
			return true
		end]]

		local Mana_Min,Mana_Max = target:getMaxMana() / 4.3, target:getMaxMana() / 2.2
		if not doTargetCombatMana(0, target.uid, Mana_Min, Mana_Max, CONST_ME_MAGIC_BLUE) then
			return false
		end
		player:addCondition(exhaust)
		--target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
		item:remove(1)
		--player:addItem(greatEmptyPot, 1)
	end
	return true
end
