local config = {
	[1] = { -- Drogheda
		fromPosition = Position(2, 2, 6),
		toPosition = Position(2, 2, 7),
		mapName = 'drogheda',
		yasirPosition = Position(947, 978, 7)
	},
	[2] = { -- Queimada
		--[[removeItems = {
			{position = Position(32393, 31814, 6), itemId = 10408},
			{position = Position(32393, 31815, 6), itemId = 10408},
			{position = Position(32393, 31816, 6), itemId = 10408}
		},]]--
		fromPosition = Position(1178, 860, 2),
		toPosition = Position(1188, 877, 7),
		mapName = 'queimada',
		yasirPosition = Position(1183, 871, 7)
	}--[[,
	[3] = { -- Liberty Bay
		fromPosition = Position(32311, 32884, 1),
		toPosition = Position(32318, 32904, 7),
		mapName = 'libertybay',
		yasirPosition = Position(32314, 32895, 6)
	}]]--
}

local yasirEnabled = true
local yasirChance = 75

local function spawnYasir(position)
	local npc = Game.createNpc('Sandra', position)
	if npc then
		npc:setMasterPos(position)
	end
end

function onStartup()
	if yasirEnabled then
		math.randomseed(os.time())
		if math.random(100) <= yasirChance then
			local randTown = config[math.random(#config)]
			iterateArea(
				function(position)
					local tile = Tile(position)
					if tile then
						local items = tile:getItems()
						if items then
							for i = 1, #items do
								items[i]:remove()
							end
						end

						local ground = tile:getGround()
						if ground then
							ground:remove()
						end
					end
				end,
				randTown.fromPosition,
				randTown.toPosition
			)

			if randTown.removeItems then
				local item
				for i = 1, #randTown.removeItems do
					item = Tile(randTown.removeItems[i].position):getItemById(randTown.removeItems[i].itemId)
					if item then
						item:remove()
					end
				end
			end

			Game.loadMap('data/world/worldchanges/' .. randTown.mapName .. '.otbm')
			addEvent(spawnYasir, 5000, randTown.yasirPosition)
		end
	end
end
