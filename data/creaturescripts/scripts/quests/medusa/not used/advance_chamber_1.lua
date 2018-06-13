local config = {
	centerRoomPosition = Position(1209, 666, 11),
	startPosition = Position(1217, 641, 9),
	nextChamberStartPosition = Position(1255, 666, 11),
	nextMonsterPosition = Position(1255, 661, 11)
	}

function onKill(player, target)

if target:getName():lower() == "dragon" then
		return true
	end

local spectator = Game.getSpectators(config.centerRoomPosition, false, false, 9, 9, 9, 9)
		for i = 1, #spectator do
			if spectator:isMonster() then
				spectator[i]:teleportTo(Position(config.startPosition))
				spectator:remove()
		end


		player:say("You have not won yet!", TALKTYPE_MONSTER_SAY, false, player, Position(config.nextChamberStartPosition))
		
		Game.createMonster("Demon", config.nextMonsterPosition)
		player:teleportTo(Position(config.nextChamberStartPosition))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
	end
end