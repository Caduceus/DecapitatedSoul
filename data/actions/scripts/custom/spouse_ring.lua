function onUse(player, item, fromPosition, itemEx, toPosition)
local playerSpouse = getPlayerSpouse(player:getGuid())
local spouseName = getPlayerNameById(playerSpouse)
local target = Creature(spouseName)

	
	if getPlayerMarriageStatus(player:getGuid()) ~= MARRIED_STATUS then
		player:say('You are not married!', TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	elseif target == nil then
		player:sendCancelMessage("Your spouse is not online.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
    elseif player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:say('You cant teleport to your spouse while in combat!', TALKTYPE_MONSTER_SAY)
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    elseif player:getStorageValue(Storage.spouseRing) > os.time() then
        player:sendCancelMessage("You can only teleport to your spouse once per hour.")
        return true
     end
	
    player:teleportTo(target:getPosition())
    player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
    player:setStorageValue(Storage.spouseRing, os.time() + 1*60*60)
    return true
end
