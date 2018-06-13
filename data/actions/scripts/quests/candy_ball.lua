local config = {
	[12543] = {'orshabaal', 'diabolical imp', 'banshee', 'fire lord', 'lich'} -- deluxe
}


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	--[[local monsterNames = config[item.itemid]
	if not monsterNames then
		return false
	end
	
	--doSetMonsterOutfit(player, monsterNames[math.random(#monsterNames)],30 * 1000)
	doSetCreatureOutfit(player, monsterNames[math.random(#monsterNames)],30 * 1000)
	item:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	item:remove(1)
	return true
end]]
local pos = player:getPosition()
if getTilePzInfo(pos) == true then 
		player:say('You cannot use this item in a protection zone.', TALKTYPE_MONSTER_SAY)
	return false
    end

local randomValue = math.random(1, 6)
	if randomValue == 1 then
		player:addItem(6569, math.random(1, 100))
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		item:remove(1)
	end 
	if randomValue == 2 then
		player:addItem(9005, math.random(1, 100))
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		item:remove(1)
	end 
	if randomValue == 3 then
		player:addItem(2097, 1)
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		item:remove(1)
	end 
	if randomValue == 4 then
		--player:addItem(2097, 1)
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		Game.createMonster("rat", pos)
		item:remove(1)
	end
	if randomValue == 5 then
		--player:addItem(7634)
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		Game.createMonster("cat", pos)
		item:remove(1)
	end
	if randomValue == 6 then
		--player:addItem(2097, 1)
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		Game.createMonster("rabbit", pos)
		item:remove(1)
	end
	return true
end