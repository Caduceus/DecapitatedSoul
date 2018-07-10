function onUse(player, item, fromPosition, target, toPosition, isHotkey)
local pos = player:getPosition()
	if getTilePzInfo(pos) == true then 
		player:say('You cannot use this egg in a protection zone.', TALKTYPE_MONSTER_SAY)
	return false
    end
	if item.itemid == 11198 then
		Game.createMonster("tarantula", pos)
		player:say('What the..', TALKTYPE_MONSTER_SAY)
		item:remove(1)
	end 
end 
