local combat = Combat()
    combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
    combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, 1)
    combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STUN)
    combat:setParameter(COMBAT_FORMULA_SKILL, 0, 0, 1.0, 0)
    combat:setArea(createCombatArea(AREA_CIRCLE3X3))
 
function onTargetCreature(creature, target)
    local speed = target:getSpeed(creature)
    local newSpeed = target:getBaseSpeed()
    
    local function speedChange()
		target:changeSpeed(newSpeed)
	end
	
    target:changeSpeed(-speed)
    addEvent(speedChange, 8000)
end
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
 
function onCastSpell(creature, var)
    return combat:execute(creature, var)
end
