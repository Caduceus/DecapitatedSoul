--Plants that don't need water...for the moment
local watered = {7673, 7670, 7680, 7682, 7684, 7686, 7688, 7690, 7992, 7994, 9982, 9990, 9986, 9988} 

--The first time the plant type will be recognizable
local plantspecies = {7680, 7682, 7684, 7686, 9982, 9986} 

--When you water this plant's, they don't change, but the time remaining for them to dry resets
local laststadium = {7689, 7691, 7693, 7695, 9991, 9989} 

--Whitered plants Id's and the plant's they will become when recovered
local witheredplants = {[7674] = 7688, [7675] = 7690, [7676] = 7692, [7677] = 7694, [9984] = 9990, [9985] = 9988} 

--In what will it transforms to if it advances or not
local plantadvances = {[7679] = {7670, 7673}, [7681] = {7688, 7680}, [7683] = {7690, 7682}, [7685] = {7692, 7684}, [7687] = {7694, 7686}, [9983] = {9990, 9982}, [9987] = {9988, 9986}} 

local CHANCES = 50 --Chances of advancing to the next stadium

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local withered = witheredplants[target.itemid]
local random = math.random(100)

    if withered ~= nil then --fixed
		target:transform(withered)
		player:sendTextMessage(TALKTYPE_ORANGE_1, "You finally remembered to water your plant and it recovered.")
    elseif target:getId() == 7655 then --fixed
		player:sendTextMessage(TALKTYPE_ORANGE_1, "You should plant some seeds first.")
    elseif target:getId() == 7665 then --fixed
		target:transform(target.itemid + 8)
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant..")
    elseif isInArray(watered, target.itemid) then -- fixed
		player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant doesn't need water.")
    elseif plantadvances[target.itemid] ~= nil then  --fixed
        if random <= chances then
            target:transform(plantadvances[target.itemid][1])
            player:sendTextMessage(TALKTYPE_ORANGE_1, "Your plant has grown to the next stage!")
            return true
        else
            target:transform(plantadvances[target.itemid][2])
            player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
            return true
        end
    elseif itemEx.itemid == 7678 then
        if RANDOM <= CHANCES then
            doCreatureSay(cid,"Your plant has grown to the next stage!",TALKTYPE_ORANGE_1)
            doTransformItem(itemEx.uid,PLANTSPECIES[math.random(4)])
        else
            doCreatureSay(cid,"You watered your plant.",TALKTYPE_ORANGE_1)
            doTransformItem(itemEx.uid,itemEx.itemid-8)
        end    
    elseif isInArray(laststadium, item.itemid) == true then
        player:sendTextMessage(TALKTYPE_ORANGE_1, "You watered your plant.")
        doTransformItem(item.uid,item.itemid-1)
    end
	target:decay()
    return true
end
