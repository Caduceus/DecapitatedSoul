--[[function Creature:onChangeOutfit(outfit)
	return true
end]]
--[[ Params
	registerEnum(CONDITION_PARAM_HEALTHTICKS)
	registerEnum(CONDITION_PARAM_MANATICKS)
	registerEnum(CONDITION_PARAM_DELAYED)
	registerEnum(CONDITION_PARAM_SPEED)
	registerEnum(CONDITION_PARAM_LIGHT_LEVEL)
	registerEnum(CONDITION_PARAM_LIGHT_COLOR)
	registerEnum(CONDITION_PARAM_SOULGAIN)
	registerEnum(CONDITION_PARAM_SKILL_MELEE)
	registerEnum(CONDITION_PARAM_SKILL_FIST)
	registerEnum(CONDITION_PARAM_SKILL_CLUB)
	registerEnum(CONDITION_PARAM_SKILL_SWORD)
	registerEnum(CONDITION_PARAM_SKILL_AXE)
	registerEnum(CONDITION_PARAM_SKILL_DISTANCE)
	registerEnum(CONDITION_PARAM_SKILL_SHIELD)
	registerEnum(CONDITION_PARAM_SKILL_FISHING)
	registerEnum(CONDITION_PARAM_STAT_MAXHITPOINTS)
	registerEnum(CONDITION_PARAM_STAT_MAXMANAPOINTS)
	registerEnum(CONDITION_PARAM_STAT_MAGICPOINTS)
	registerEnum(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT)
	registerEnum(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT)
	registerEnum(CONDITION_PARAM_STAT_MAGICPOINTSPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_MELEEPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_FISTPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_CLUBPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_SWORDPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_AXEPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_DISTANCEPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_SHIELDPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_FISHINGPERCENT)
	registerEnum(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCEPERCENT)]]


--[[ Outfit Bonus start]]
local speed = Condition(CONDITION_HASTE)
speed:setParameter(CONDITION_PARAM_TICKS, -1)
speed:setParameter(CONDITION_PARAM_SUBID, 100)
speed:setParameter(CONDITION_PARAM_SPEED, 300)
 
local hp = Condition(CONDITION_ATTRIBUTES)
hp:setParameter(CONDITION_PARAM_TICKS, -1)
hp:setParameter(CONDITION_PARAM_SUBID, 101)
hp:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, 110)

local mp = Condition(CONDITION_ATTRIBUTES)
mp:setParameter(CONDITION_PARAM_TICKS, -1)
mp:setParameter(CONDITION_PARAM_SUBID, 102)
mp:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, 110)

local magic = Condition(CONDITION_ATTRIBUTES)
magic:setParameter(CONDITION_PARAM_TICKS, -1)
magic:setParameter(CONDITION_PARAM_SUBID, 103)
magic:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 5)

local distance = Condition(CONDITION_ATTRIBUTES)
distance:setParameter(CONDITION_PARAM_TICKS, -1)
distance:setParameter(CONDITION_PARAM_SUBID, 104)
distance:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, 110)

local sword = Condition(CONDITION_ATTRIBUTES)
sword:setParameter(CONDITION_PARAM_TICKS, -1)
sword:setParameter(CONDITION_PARAM_SUBID, 105)
sword:setParameter(CONDITION_PARAM_SKILL_SWORDPERCENT, 110)

local club = Condition(CONDITION_ATTRIBUTES)
club:setParameter(CONDITION_PARAM_TICKS, -1)
club:setParameter(CONDITION_PARAM_SUBID, 106)
club:setParameter(CONDITION_PARAM_SKILL_CLUBPERCENT, 110)

local axe = Condition(CONDITION_ATTRIBUTES)
axe:setParameter(CONDITION_PARAM_TICKS, -1)
axe:setParameter(CONDITION_PARAM_SUBID, 107)
axe:setParameter(CONDITION_PARAM_SKILL_AXEPERCENT, 110)

local shield = Condition(CONDITION_ATTRIBUTES)
shield:setParameter(CONDITION_PARAM_TICKS, -1)
shield:setParameter(CONDITION_PARAM_SUBID, 108)
shield:setParameter(CONDITION_PARAM_SKILL_SHIELDPERCENT, 110) 

local melee = Condition(CONDITION_ATTRIBUTES)
melee:setParameter(CONDITION_PARAM_TICKS, -1)
melee:setParameter(CONDITION_PARAM_SUBID, 109)
melee:setParameter(CONDITION_PARAM_SKILL_MELEEPERCENT, 150)

oldOutfit = {}

outfitBonuses = {
    --[[[128] = {[1] = {condition = distance}, [2] = {condition = melee}, [3] = {condition = hp}},
    [129] = {[3] = {condition = hp}},
    [130] = {[3] = {condition = {mp}}},
    [131] = {[1] = {condition = hp}, [2] = {condition = sword}, [3] = {condition = {shield, speed, melee}}},]]
    --[633] = {[1] = {condition = hp}, [2] = {condition = melee}, [3] = {condition = {shield, hp, melee}}}
}


function Creature:onChangeOutfit(outfit)
    if self:isPlayer() then
        local getOutfit = self:getOutfit()
        oldOutfit[self:getId()] = { --Colors (Head, Body, Legs, Feet) and lookTypeEx are unused, but I still keep them here because I'm stupid.
            lookHead = getOutfit.lookHead;
            lookBody = getOutfit.lookBody;
            lookLegs = getOutfit.lookLegs;
            lookFeet = getOutfit.lookFeet;
            lookType = getOutfit.lookType;
            lookTypeEx = getOutfit.lookTypeEx;
            lookAddons = getOutfit.lookAddons;
            lookMount = getOutfit.lookMount;
        }

        local old = oldOutfit[self:getId()]
        local oldOutfit_t = outfitBonuses[old.lookType]
        if oldOutfit_t and oldOutfit_t[old.lookAddons] then
            local oldCondition = oldOutfit_t[old.lookAddons].condition
            if type(oldCondition) == "table" then
                for _, condition in pairs(oldCondition) do
                    self:removeCondition(condition:getType(), condition:getId(), condition:getSubId())
                end
            else
                self:removeCondition(oldCondition:getType(), oldCondition:getId(), oldCondition:getSubId())
            end
        end

        local currentOutfit = outfitBonuses[outfit.lookType]
        if currentOutfit and currentOutfit[outfit.lookAddons] then
            local newCondition = currentOutfit[outfit.lookAddons].condition
            if type(newCondition) == "table" then
                for _, condition in pairs(newCondition) do
                    self:addCondition(condition)
                end
            else
                self:addCondition(newCondition)
            end
        end
    end
    return true
end

--[[Outfit Bonus end]]


--[[function Creature:onChangeOutfit(outfit)
	return true
end]]

function Creature:onAreaCombat(tile, isAggressive)
	return true
end

function Creature:onTargetCombat(target)
	if not self then
		return true
	end
	
	if not self then return true end
	if self:isPlayer() and target:isMonster() then
		target:registerEvent("extra_loot_d")
	end
	
	if PARTY_PROTECTION ~= 0 then
		if self:isPlayer() and target:isPlayer() then
			local party = self:getParty()
			if party then
				local targetParty = target:getParty()
				if targetParty and targetParty == party then
					return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
				end
			end
		end
	end
	
	if ADVANCED_SECURE_MODE ~= 0 then
		if self:isPlayer() and target:isPlayer() then
			if self:hasSecureMode() then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
		end
	end
	return true
end