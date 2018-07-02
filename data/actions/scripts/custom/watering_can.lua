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

	if target:getId() == 7655 then
		player:sendTextMessage(TALKTYPE_ORANGE_1, "You should plant a seed first.")
		return true
    end
   if target:getId() == 7665 then
		target:transform(target.itemid + 8)
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant..")
        return true
    end
	if isInArray(watered, target.itemid) then
		player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant doesn't need water.")
		return true
    end
   if withered ~= nil then
		target:transform(withered)
		player:sendTextMessage(TALKTYPE_ORANGE_1, "You finally remembered to water your plant and it recovered.")
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		return true
    end
    if target:getId() == 7678 then
        if random <= chances then
            player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant has grown to the next stage!")
            target:transform(plantspecies[math.random(#plantspecies)], 1)
            return true
        else
            player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
            target:transform(target.itemid -8)
            return true
        end    
    elseif isInArray(lastphase, item.itemid) == true then
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
        doTransformItem(item.uid,item.itemid-1)
    end
    if isInArray(lastphase, target.itemid) == true then
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
        target:transform(target.itemid -1)
        return true
        end
    if plantadvances[target.itemid] ~= nil then 
        if random <= chances then
            target:transform(plantadvances[target.itemid][1])
            player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant has grown to the next stage!")
            return true
        else
            target:transform(plantadvances[target.itemid][2])
            player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
            return true
        end
    end
   return false
end
