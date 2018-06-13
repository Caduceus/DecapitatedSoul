function spellCallback(cid, position, count)
	if Creature(cid) then
		if count > 0 or math.random(0, 1) == 1 then
			position:sendMagicEffect(CONST_ME_ICETORNADO)
			position:sendMagicEffect(CONST_ME_BIGCLOUDS)
			doAreaCombatHealth(cid, COMBAT_ICEDAMAGE, position, 0, -1000, -1000, CONST_ME_WATERSPLASH)
		end

		if count < 5 then
			count = count + 1
			addEvent(spellCallback, math.random(100, 500), cid, position, count)
		end
	end
end

function onTargetTile(creature, position)
	spellCallback(creature:getId(), position, 0)
end

local combat = Combat()
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:setParameter(COMBAT_PARAM_PVPDAMAGE, 250)

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 8.0) + 25
	local max = (level / 5) + (maglevel * 16) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end

