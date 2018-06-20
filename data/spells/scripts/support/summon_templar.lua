function onCastSpell(player, variant)

        local config = { 
			playerPos = player:getPosition(),
            guardian = "templar",
            deSpawn = 2 * 60
            }
            local pos = player:getPosition()
				if getTilePzInfo(pos) == true then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot cast this spell in a protection zone!")
					return false
				end
				
                if #player:getSummons() == 1 then
						player:getPosition():sendMagicEffect(CONST_ME_POFF)
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have a guardian.")
                        return false -- true allows casting of spell, false has been producing errors on sendMagicEffect. 
                end
                
        local monster = Game.createMonster(config.guardian, config.playerPos)
			if monster then
				addEvent(function(cid)
				local monster = Monster(cid)
					if monster == nil then
					return false
				end
					monster:say("UNTIL WE MEET AGAIN!", TALKTYPE_MONSTER_YELL)
					monster:getPosition():sendMagicEffect(CONST_ME_POFF)
					monster:remove()
					end, config.deSpawn * 1000, monster:getId())
										
        -- Place the monster
         monster:setMaster(player)
         local hp = monster:getMaster():getMaxHealth()
         local outfit = monster:getMaster():getOutfit()
			if hp > monster:getMaxHealth() then
				monster:setOutfit(outfit)
				monster:setMaxHealth(hp)
				monster:addHealth(hp)
				monster:say("".. player:getName() .."'s Guardian to the rescue!", TALKTYPE_MONSTER_YELL)
				config.playerPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
		return true
        end
	end
end