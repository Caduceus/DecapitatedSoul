local pos = {x = 959, y = 1017, z = 8}

function onStepIn(cid, item, position, fromPosition)
local player = Player(cid)
    if not player then
        return true
    end
	local phrase = {
		'Steaming ahead, ' .. player:getName() ..'!',
		'Whew!',
		'All aboard the temple train!',
		'' .. player:getName() ..' Express.'
	}
	local p = phrase[math.random(#phrase)] 
		player:teleportTo(pos)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say(p, TALKTYPE_MONSTER_SAY)
end
