function onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end
    local effectPos = Position(1024, 912, 7)
    if item.actionid == 16016 then
		if player:getStorageValue(45555) < 1 then
   			player:say('Hey You! Over here!', TALKTYPE_MONSTER_SAY, false, 0, effectPos)
				effectPos:sendMagicEffect(CONST_ME_TUTORIALARROW)
                return true
            end
        end
    end