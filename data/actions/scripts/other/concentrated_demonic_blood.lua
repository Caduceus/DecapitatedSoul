function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local pos = player:getPosition()
	if getTilePzInfo(pos) == true then 
		player:say('You cannot use this item in a protection zone.', TALKTYPE_MONSTER_SAY)
	return false
    end
  
local randomValue = math.random(1, 6)
	if randomValue == 1 then
		player:addItem(7590, math.random(1, 100))
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		item:remove()
	end 
	if randomValue == 2 then
		player:addItem(7591, math.random(1, 100))
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		item:remove()
	end
	if randomValue == 3 then
		player:addItem(8472, math.random(1, 100))
		item:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		item:remove()
	end 
	if randomValue > 3 then
		player:addItem(7634)
		Game.createMonster("Demon", pos)
		item:remove()
	end
	return true
end
