CreatureArena = {}
PLAYER_LASTARENA = {}

Arena = {}
setmetatable(Arena, {__call =
	function(_, name, position, exit, radius, rewardpos)
		return setmetatable({name = name, position = position, exit = exit, currentwave = 1, rewardpos = rewardpos or exit, radius = radius, waves = {}, playertable = {}}, {__index = Arena})
	end})

Wave = {}
setmetatable(Wave, {__call =
	function(_, monsters)
		return setmetatable({monsters = monsters}, {__index = Wave})
	end})



local function getBaseVocation(vocation)
    while vocation:getDemotion() do
        vocation = vocation:getDemotion()
    end
    return vocation
end

function Arena:addPlayerPosition(position, level, vocation)
	table.insert(self.playertable, {position, level, vocation})
	return true
end

function Arena:setRewardCallback(callback)
	self.rewardcallback = callback
end

function Arena:setCheckCallback(callback)
	self.checkcallback = callback
end

function Arena:setSpawnCallback(callback)
	self.spawncallback = callback
end

function Arena:setWaveclearCallback(callback)
	self.waveclearcallback = callback
end

function Arena:setJokerdeathCallback(callback)
	self.jokerdeathcallback = callback
end

function Arena:setStartCallback(callback)
	self.startcallback = callback
end

function Arena:setThinkCallback(callback, interval)
	if type(callback) == "function" then
		self.think = callback
		self.thinkinterval = interval or 2000
	end
end

function Arena:onThink()
	if self.think and self.thinking then
		self.think(self, self.thinkinterval)
		self.thinkevent = addEvent(Arena.onThink, self.thinkinterval, self)
	end
end

function Arena:addWaves(x, ...)
	if x then
		table.insert(self.waves, x)
		return self:addWaves(...)
	end
end

function Arena:getPlayersInside()
	local specs = Game.getSpectators(self.position, false, true, self.radius, self.radius, self.radius, self.radius)
	return specs
end

function Arena:removeCreatures()
	local specs = Game.getSpectators(self.position, false, false, self.radius, self.radius, self.radius, self.radius)
	for i = 1, #specs do
		if specs[i]:isMonster() then
			specs[i]:remove()
		elseif specs[i]:isPlayer() then
			specs[i]:teleportTo(self.exit)
		end
	end
end

function Arena:getMonstersInside()
	local ret = {}
	local specs = Game.getSpectators(self.position, false, false, self.radius, self.radius, self.radius, self.radius)
	for i = 1, #specs do
		if specs[i]:isMonster() and not specs[i]:getMaster() then
			table.insert(ret, specs[i])
		end
	end

	return ret
end

function Arena:setJokerCreature(name)
	self.joker = name
end

function Arena:jokerDeath()
	if self.jokerdeathcallback then
		local players = self:getPlayersInside()
		for i = 1, #players do
			self.jokerdeathcallback(players[i], self.currentwave, self)
		end
	end
	addEvent(Arena.spawnWave, self.delay or 1000, self)
end

function Arena:setDelayWaves(t)
	self.delay = t
end

function Arena:setDelayEnd(t)
	self.endtime = t
end

function Arena:reset()
	self.currentwave = 1
	self.started = false
	self.thinking = false
	stopEvent(self.thinkevent)
	self:removeCreatures()
end

function Arena:isActive()
	local players = self:getPlayersInside()
	if self.started and #players > 0 then
		return true
	else
		self:reset()
	end

	return false
end

function Arena:spawnJoker()
	local pos = self.position
	local radius = self.radius

	local creature = Game.createMonster(self.joker, Position(math.random(pos.x-radius, pos.x+radius), math.random(pos.y-radius, pos.y+radius), pos.z), false, false)
	if creature then
		CreatureArena[creature:getId()] = self
		creature:registerEvent("JokerDeath")
	else
		self:spawnJoker()
	end
end

function Arena:finish()
	local players = self:getPlayersInside()
	for i = 1, #players do
		players[i]:teleportTo(self.rewardpos)
		if self.rewardcallback then
			self.rewardcallback(players[i], self)
		end
	end

	self:reset()
end

function Arena:spawnWave()
	local wave = self.waves[self.currentwave]
	if wave then
		if self.spawncallback then
			local players = self:getPlayersInside()
			for i = 1, #players do
				self.spawncallback(players[i], self.currentwave, self)
			end
		end

		wave:spawn(self)
	end
end

function Arena:startWave()
	local wave = self.waves[self.currentwave]

	if not wave then
		return self:finish()
	end

	if self.joker then
		self:spawnJoker()
	else
		addEvent(Arena.spawnWave, self.delay or 1000, self)
	end
end

function Arena:start(aplayer)
	if #self.playertable > 0 then
		local group = {}
		for i = 1, #self.playertable do
			local tile = Tile(self.playertable[i][1])
			if tile then
				local player = tile:getTopCreature()
				if player and player:isPlayer() then
					local minlevel = self.playertable[i][2] or 0
					local vocation = self.playertable[i][3]
					if player:getLevel() >= minlevel then
						if not vocation or getBaseVocation(player:getVocation()) == vocation then
							if self.checkcallback and not self.checkcallback(player) then
								return false
							end

							table.insert(group, player)
						else
							aplayer:sendCancelMessage(player:getName() .. " needs to be " .. vocation:getName() .. ".")
							return false
						end
					else
						aplayer:sendCancelMessage(player:getName() .. " needs to be level " .. minlevel)
						return false
					end
				else
					aplayer:sendCancelMessage("No players in the required positions.")
					return false
				end
			end
		end

		if #group == #self.playertable then
			self.started = true
			for i = 1, #group do
				group[i]:teleportTo(self.position)
				PLAYER_LASTARENA[group[i]:getGuid()] = self

				if self.startcallback then
					self.startcallback(group[i], self)
				end
			end

			if self.think then
				self.thinking = true
				self:onThink()
			end

			self:startWave()
			return true
		else
			aplayer:sendCancelMessage("No players in the required positions.")
			return false
		end
	else
		print("Arena with no player position.")
	end

	return false
end

function Arena:useLever(player)
	if self:isActive() then
		player:sendCancelMessage("Someone is already inside the arena, please wait.")
		return false
	else
		return self:start(player)
	end
end

function Arena:monsterDeath()
	local monsters = self:getMonstersInside()
	if #monsters == 1 then
		if self.waveclearcallback then
			local players = self:getPlayersInside()
			for i = 1, #players do
				self.waveclearcallback(players[i], self.currentwave, self)
			end
		end

		self.currentwave = self.currentwave+1
		self:startWave()
	end
end

function Wave:spawn(arena)
	local pos = arena.position
	local radius = arena.radius

	for name, amount in pairs(self.monsters) do
		for i = 1, amount do
			local creature = Game.createMonster(name, Position(math.random(pos.x-radius, pos.x+radius), math.random(pos.y-radius, pos.y+radius), pos.z), false, false)
			if creature then
				CreatureArena[creature:getId()] = arena
				creature:registerEvent("ArenaEvent")
			end
		end
	end
end

function Player:isInsideArena(arena)
	local players = arena:getPlayersInside()
	return isInArray(players, self)
end

function Player:getLastArena()
	return PLAYER_LASTARENA[self:getGuid()]
end