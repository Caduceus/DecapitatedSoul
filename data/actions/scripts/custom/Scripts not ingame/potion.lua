-- =============================================================================================================================================================== --
-- ===================	CREATED BY CODINABLACK@OTLAND.NET CREDITS TO OTLAND FOR HELPING ME TO LEARN EVERY KIND OF CODING USED IN THIS SCRIPT ====================== --
-- =============================================================================================================================================================== --
local config = {
lvl = 1, -- the multiplier for how much level matters. Default 1.
mlvl = 1, -- the mulitplier for how much mlvl matters. Default 1.
forMin = 0.9, -- forumula multiplier for MIN/max range. Default 0.9 == 90%  		--Change both to 1.0 for amount healed to have no min/max
forMax = 1.1, -- forumula multiplier for min/MAX range. Default 0.9 == 110%  		--Change both to 1.0 for amount healed to have no min/max
removeOnUse = true, -- Does this remove 1 potion after it's use? true/false  		-- Default true.
useOnSummons = true, -- Can you use this on a players summon? true/false  			-- Default true.
useOnGuildSummon = true, -- Can you use this on guild mate's summon? true/false  	-- Default true.
useOnPartySummon = true, -- Can you use this on a party members summon? true/false  	-- Default true.
realPvpMode = true, -- True = Players can't use potions for hotkeys || False = Players are allowed to use potions for hotkeys.
exhaust = Condition(CONDITION_EXHAUST_HEAL, CONDITIONID_HEAD),
cooldown =  Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_HEAD)
}
local POTIONS = {
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  [8704] = {empty = 7636, spellid = 1, splash = 2, exhaust = 2000, health = true, mana = false, healthpercent = 8}, 																		-- small health potion
  [7618] = {empty = 7636, spellid = 1, splash = 2, exhaust = 2000, health = true, mana = false, healthpercent = 12},																		-- health potion
  [7588] = {empty = 7634, spellid = 2, splash = 2, exhaust = 2000, health = true, mana = false, healthpercent = 25, lvlReq = 50, vocations = {1, 3, 4, 7, 8, 12}},							-- strong health potion
  [7591] = {empty = 7635, spellid = 2, splash = 2, exhaust = 2000, health = true, mana = false, healthpercent = 40, lvlReq = 80, vocations = {4, 8, 12}}, 									-- great health potion
  [8473] = {empty = 7635, spellid = 2, splash = 2, exhaust = 2000, health = true, mana = false, healthpercent = 60, lvlReq = 150, vocations = {4, 8, 12}}, 									-- ultimate health potion
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  [7620] = {empty = 7636, spellid = 3, splash = 7, exhaust = 2000, health = false, mana = true, manapercent = 12}, 																			-- mana potion
  [7589] = {empty = 7634, spellid = 3, splash = 7, exhaust = 2000, health = false, mana = true, manapercent = 25, lvlReq = 50, vocations = {1, 2, 3, 5, 6, 7, 9, 10, 11}},		 			-- strong mana potion
  [7590] = {empty = 7635, spellid = 3, splash = 7, exhaust = 2000, health = false, mana = true, manapercent = 40, lvlReq = 80, vocations = {1, 2, 5, 6, 9, 10}}, 							-- great mana potion
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  [8472] = {empty = 7635, spellid = 2, splash = 3, exhaust = 2000, health = true,  mana = true, healthpercent = 60, manapercent = 60, lvlReq = 100, vocations = {3, 7, 11}} 					-- great spirit potion
}
function onUse(caster, item, fromPosition, itemEx, toPosition, isHotkey)
	if isHotkey and config.realPvpMode == true then
		caster:getPosition():sendMagicEffect(CONST_ME_POFF)
		return caster:sendTextMessage(MESSAGE_INFO_DESCR,"Hotkey use is disabled for potions!")
	end
	if toPosition.z == 0 or nil then
		caster:getPosition():sendMagicEffect(CONST_ME_POFF)
		return caster:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	end
	if toPosition.x == 65535 or nil then
		caster:getPosition():sendMagicEffect(CONST_ME_POFF)
		return caster:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	end
local CGID = 0
local CPID = 0
local mlevel = caster:getMagicLevel()
local level = caster:getLevel()
local potion = POTIONS[item.itemid]
local health = potion.health
local mana = potion.mana
local hpPercent = potion.healthpercent
local mpPercent = potion.manapercent
local exhaust = config.exhaust
local cooldown = config.cooldown
local targetItem = Item(itemEx.uid)
	if targetItem then
		if (not targetItem:hasProperty()) then
			Item(doCreateItem(2016, potion.splash, toPosition)):decay()
				if config.removeOnUse and not caster:getGroup():getAccess() then
					Item(item.uid):remove(1)
				end
			return true
		end
		caster:getPosition():sendMagicEffect(CONST_ME_POFF)
		return caster:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	end
local target = Creature(itemEx.uid)
local healthmax = target:getMaxHealth()
local manamax = target:getMaxMana()

	if(not potion) then
		return false
	end
	if caster:getCondition(CONDITION_EXHAUST_HEAL, CONDITIONID_HEAD, potion.spellid) then
		caster:getPosition():sendMagicEffect(CONST_ME_POFF)
		return caster:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
	end
	if (potion.vocations) and  (not caster:getGroup():getAccess()) then
		if (not isInArray(potion.vocations, caster:getVocation():getId())) then
			caster:getPosition():sendMagicEffect(CONST_ME_POFF)
			return caster:sendTextMessage(MESSAGE_INFO_DESCR,"Your vocation may not use this fluid")
		end
	end
	if((potion.lvlReq and caster:getLevel() < potion.lvlReq) and not caster:getGroup():getAccess()) then 
		caster:getPosition():sendMagicEffect(CONST_ME_POFF)
		return caster:sendTextMessage(MESSAGE_INFO_DESCR,"Only players of " ..potion.level.. " or above may use this fluid.")
	end
	if target:isPlayer() then
		if health == true then
			target:addHealth( math.random((((healthmax/100)*hpPercent ) + ((level/12)*config.lvl ) + ((mlevel/18)*config.mlvl ))*config.forMin, ((((healthmax/100)*hpPercent ) + ((level/12)*config.lvl )+ ((mlevel/18))*config.mlvl )*config.forMax)))
		end
		if mana == true then
			target:addMana( math.random((((manamax/100)*mpPercent ) + ((level/18)*config.lvl ) + ((mlevel/12)*config.mlvl ))*config.forMin, ((((manamax/100)*mpPercent ) + ((level/18)*config.lvl )+ ((mlevel/12))*config.mlvl )*config.forMax)))
		end
	end
	if target:isMonster() then
	local monsterMaster = target:getMaster()
		if caster:isCreatureFriend(target, true) then
			if config.useOnSummons == true then
				if health then
					target:addHealth( math.random((((healthmax/100)*hpPercent ) + ((level/12)*config.lvl ) + ((mlevel/18)*config.mlvl ))*config.forMin, ((((healthmax/100)*hpPercent ) + ((level/12)*config.lvl )+ ((mlevel/18))*config.mlvl )*config.forMax)))
				else
					caster:getPosition():sendMagicEffect(CONST_ME_POFF)
					return caster:sendTextMessage(MESSAGE_STATUS_SMALL,"Summons don't use mana!")
				end
			else
				caster:getPosition():sendMagicEffect(CONST_ME_POFF)
				return caster:sendTextMessage(MESSAGE_STATUS_SMALL,"You can't use this on summons!")
			end
		else
			caster:getPosition():sendMagicEffect(CONST_ME_POFF)
			return caster:sendTextMessage(MESSAGE_STATUS_SMALL,"You can't use this on that creature!")
		end
	end		
	if target:isNpc() then
		caster:getPosition():sendMagicEffect(CONST_ME_POFF)
		return caster:sendTextMessage(MESSAGE_STATUS_SMALL,"You can't use this on that creature!")
	end
	if config.removeOnUse and not caster:getGroup():getAccess() then
		Item(item.uid):remove(1)
	end
	exhaust:setParameter(CONDITION_PARAM_TICKS, potion.exhaust)
	exhaust:setParameter(CONDITION_PARAM_SUBID, potion.spellid)
	cooldown:setParameter(CONDITION_PARAM_TICKS, potion.exhaust)
	cooldown:setParameter(CONDITION_PARAM_SUBID, potion.spellid)
	caster:addCondition(cooldown)
	caster:addCondition(exhaust)
	target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	target:say("Aaaah...", TALKTYPE_MONSTER_SAY)
  return true
end