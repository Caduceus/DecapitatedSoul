function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    local effectPos = Position(1021, 899, 7)
    local sayPos = Position(1020, 902, 7)
    
    local function keatonSay()
		player:say('Not sure how much longer I can fight these off!', TALKTYPE_MONSTER_SAY, false, 0, sayPos)
	end

    if item.actionid == 16020 then
		if player:getStorageValue(45557) < 1 then
				addEvent(keatonSay, 3 * 1000)
				effectPos:sendMagicEffect(CONST_ME_FIREATTACK)
                return true
            end
        end
    end