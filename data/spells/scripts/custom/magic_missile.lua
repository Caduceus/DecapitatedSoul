-- Minimum amount of magic missiles
local minMissiles = 2

local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
	
local function arcaneDamage(player, var, target, missileEffectpos, animationroll)
	local player = Player(player)
	local creature = Creature(target)
		if player and creature then
			local level = player:getLevel()
			local magiclevel = player:getMagicLevel()
			local min = (level / 5) + (magiclevel * 1.2) + 5
			local max = (level / 5) + (magiclevel * 5.8) + 12
				combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
				Position(missileEffectpos):sendDistanceEffect(creature:getPosition(),CONST_ANI_ENERGYBALL)
				if animationroll == 1 then
					creature:getPosition():sendMagicEffect(CONST_ME_PURPLEENERGY)
			end
			combat:execute(player, var)
	end
	return true
end

local function arcaneBolt(player, var, target, count)
	local player = Player(player)
	local creature = Creature(target)
	if player and creature then
		local playerpos = player:getPosition()
		local creaturepos = creature:getPosition()
		local missileEffectpos = Position(playerpos)
		local differencey = playerpos.y - creaturepos.y -- positive = N, negative = S
		local differencex = playerpos.x - creaturepos.x -- positive = W, negative = E
		local ymodifier = 0
		local xmodifier = 0
		local animationroll = 0
		-- Cycle between each side of player depending if missile is even or odd
		if count % 2 == 0 then -- even
			if differencey > 0 then -- Target it to the N
				xmodifier = xmodifier + 1
				if math.random(1,2) == 2 then
					ymodifier = ymodifier - 1
				end
				elseif differencey < 0 then -- Target is to the S
					xmodifier = xmodifier - 1
					if differencey < -1 or math.random(1,2) == 2 then -- Force if 1sqm away due to client perspective
						ymodifier = ymodifier + 1
					end
				end
				if differencex < 0 then -- Target is to the E
					ymodifier = ymodifier + 1
					if differencex < -1 or math.random(1,2) == 2 then -- Force if 1sqm away due to client perspective
						xmodifier = xmodifier + 1
				end
			elseif differencex > 0 then -- Target is to the W
				ymodifier = ymodifier - 1
				if math.random(1,2) == 2 then
					xmodifier = xmodifier - 1
				end
			end
		else -- odd
			animationroll = 1
			if differencey > 0 then -- Target it to the N
				xmodifier = xmodifier - 1
				if math.random(1,2) == 2 then
					ymodifier = ymodifier - 1
				end
			elseif differencey < 0 then -- Target is to the S
				xmodifier = xmodifier + 1
				if differencey < -1 or math.random(1,2) == 2 then -- Force if 1sqm away due to client perspective
					ymodifier = ymodifier + 1
				end
			end
			if differencex < 0 then -- Target is to the E
				ymodifier = ymodifier - 1
				if differencex < -1 or math.random(1,2) == 2 then -- Force if 1sqm away due to client perspective
					xmodifier = xmodifier + 1
				end
			elseif differencex > 0 then -- Target is to the W
				ymodifier = ymodifier + 1
				if math.random(1,2) == 2 then
					xmodifier = xmodifier - 1
				end
			end
		end
		missileEffectpos.x = missileEffectpos.x + xmodifier
		missileEffectpos.y = missileEffectpos.y + ymodifier
		Position(playerpos):sendDistanceEffect(missileEffectpos, CONST_ANI_ENERGYBALL)
		addEvent(arcaneDamage, 150, player.uid, var, creature.uid, missileEffectpos,animationroll)
	end
	return true
end

function onCastSpell(player, var)
	local magiclevel = player:getMagicLevel()
	local target = player:getTarget()
	local missileCount = minMissiles + math.floor(magiclevel / 50) -- extra missile every 50 magic levels
	local count = 1
	if target then
		for i = 1, missileCount do
			addEvent(arcaneBolt, 150 * (i - 1), player.uid, var, target.uid, count)
			count = count + 1
		end
	else
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "You must select a target.")
		return false
	end
	return true
end