function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local pos = player:getPosition()
	if getTilePzInfo(pos) == true then 
		player:say('You cannot use this egg in a protection zone.', TALKTYPE_MONSTER_SAY)
	return false
    end
	if item.itemid == 4850 then
		Game.createMonster("hydra", pos)
		player:say('What the..', TALKTYPE_MONSTER_SAY)
		item:remove()
	end 
end
