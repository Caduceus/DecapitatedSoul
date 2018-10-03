--Plants that don't need water.
local watered = {7673, 7670, 7680, 7682, 7684, 7686, 7688, 7690, 7692, 7992, 7994, 9982, 9990, 9986, 9988} 

--The first time the plant type will be recognizable
local plantspecies = {7680, 7682, 7684, 7686, 9982, 9986}

--When you water this plant's, they don't change, but the to decay resets
local lastphase = {7689, 7691, 7693, 7695, 9991, 9989} 

--Whitered plants Id's and the plant's they will become when recovered
local witheredplants = {[7674] = 7680, [7675] = 7682, [7676] = 7684, [7677] = 7686, [9984] = 9982, [9985] = 9986} 

--In what will it transforms to if it advances or not
local plantadvances = {[7679] = {7670, 7673}, [7681] = {7688, 7680}, [7683] = {7690, 7682}, [7685] = {7692, 7684}, [7687] = {7694, 7686}, [9983] = {9990, 9982}, [9987] = {9988, 9986}} 

local chances = 50 --Chances of advancing to the next phase

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local random = math.random(100)
	local withered = witheredplants[target.itemid]
	--[[local chance = math.random (1,10)
	
	if chance <= 5 then]]--
	
	if target:getId() == 7655 then
		player:sendTextMessage(TALKTYPE_ORANGE_1, "You should plant a seed first.")
		return true
    elseif target:getId() == 7665 and item.type == 1 then
		target:transform(target.itemid + 8)
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant..")
        item:transform(item.itemid, item.type - 1)
        return true
	elseif isInArray(watered, target.itemid) then
		player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant doesn't need water.")
		return true
    elseif withered ~= nil and item.type == 1 then
		target:transform(withered)
		player:sendTextMessage(TALKTYPE_ORANGE_1, "You finally remembered to water your plant and it recovered, slightly.")
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		item:transform(item.itemid, item.type - 1)
		return true
    elseif target:getId() == 7678 and item.type == 1 then
        if random <= chances then
            player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant has grown to the next stage!")
            target:transform(plantspecies[math.random(#plantspecies)], 1)
            item:transform(item.itemid, item.type - 1)
            return true
        else
            player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
            target:transform(target.itemid -8)
            item:transform(item.itemid, item.type - 1)
            return true
        end    
    elseif isInArray(lastphase, item.itemid) == true and item.type == 1 then
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
        doTransformItem(item.uid,item.itemid-1)
        item:transform(item.itemid, item.type - 1)
    elseif isInArray(lastphase, target.itemid) == true and item.type == 1 then
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
        target:transform(target.itemid -1)
        item:transform(item.itemid, item.type - 1)
        return true
    elseif plantadvances[target.itemid] ~= nil and item.type == 1 then 
        if random <= chances then
            target:transform(plantadvances[target.itemid][1])
            player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant has grown to the next stage!")
            item:transform(item.itemid, item.type - 1)
            return true
        else
            target:transform(plantadvances[target.itemid][2])
            player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
            item:transform(item.itemid, item.type - 1)
            return true
        end
    end
    
local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 60000)

local haste = Condition(CONDITION_HASTE)
haste:setParameter(CONDITION_PARAM_TICKS, 60000)

local poison = Condition(CONDITION_POISON)
poison:setParameter(CONDITION_PARAM_DELAYED, true)
poison:setParameter(CONDITION_PARAM_MINVALUE, -50)
poison:setParameter(CONDITION_PARAM_MAXVALUE, -120)
poison:setParameter(CONDITION_PARAM_STARTVALUE, -5)
poison:setParameter(CONDITION_PARAM_TICKINTERVAL, 4000)
poison:setParameter(CONDITION_PARAM_FORCEUPDATE, true)

local fluidType = {3, 4, 5, 7, 10, 11, 13, 15, 19, 20}
local fluidMessage = {"Aah...", "Urgh!", "Mmmh.", "Aaaah...", "Aaaah...", "Urgh!", "Urgh!", "Aah...", "Urgh!", "Ahhhh"}

    local targetItemType = ItemType(target.itemid)
    if targetItemType and targetItemType:isFluidContainer() then
        if target.type == 0 and item.type ~= 0 then
            target:transform(target:getId(), item.type)
            item:transform(item:getId(), 0)
            return true
        elseif target.type ~= 0 and item.type == 0 then
            target:transform(target:getId(), 0)
            item:transform(item:getId(), target.type)
            return true
        end
    end

    if target:isCreature() then
        if item.type == 0 then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "It is empty.")
        elseif target == player then
            if item.type == 3 or item.type == 15 then
                player:addCondition(drunk)
            elseif item.type == 4 then
                player:addCondition(poison)
            elseif item.type == 20 then
                player:addCondition(haste)
            elseif item.type == 7 then
                player:addMana(math.random(50, 150))
                fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            elseif item.type == 10 then
                player:addHealth(60)
                fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
            end
            item:transform(item:getId(), 0)
            for i = 0, #fluidType do
                if item.type == fluidType[i] or item.type == 20 then
                    player:say(fluidMessage[i], TALKTYPE_MONSTER_SAY)
                    return true
                end
            end
            player:say("Gulp.", TALKTYPE_MONSTER_SAY)
        else
            Game.createItem(2016, item.type, toPosition):decay()
            item:transform(item:getId(), 0)
        end
    else
        local fluidSource = targetItemType and targetItemType:getFluidSource() or 0
        if fluidSource ~= 0 then
            item:transform(item:getId(), fluidSource)
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Your watering can was filled.")
        elseif item.type == 0 then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Your watering can is empty.")
        else
            if toPosition.x == CONTAINER_POSITION then
                toPosition = player:getPosition()
            end
            Game.createItem(2016, item.type, toPosition):decay()
            item:transform(item:getId(), 0)
        end
    end
	return true
end
