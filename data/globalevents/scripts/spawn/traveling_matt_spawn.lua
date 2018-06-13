local config = {
	['Monday'] = Position(947, 981, 6),
	['Tuesday'] = Position(947, 1046, 6),
	['Wednesday'] = Position(1122, 878, 6),
	['Thursday'] = Position(819, 835, 6),
	['Friday'] = Position(967, 1049, 7),
	['Saturday'] = Position(1049, 1002, 7),
	['Sunday'] = Position(1172, 1201, 6)
}

-- Should Rashid spawn as in real tibia?
local spawnByDay = true

function onStartup()
	if spawnByDay then
		local npc = Game.createNpc('traveling matt', config[os.date('%A')], false, true)
		if npc then
			npc:setMasterPos(config[os.date('%A')])
		end
	else
		local npc
		for k, position in pairs(config) do
			npc = Game.createNpc('traveling matt', position, false, true)
			if npc then
				npc:setMasterPos(position)
			end
		end
	end

	return true
end
