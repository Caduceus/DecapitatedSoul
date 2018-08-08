local combat = Combat()
local condition = Condition()
    combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
    combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, 1)
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STUN)
    combat:setArea(createCombatArea(AREA_CIRCLE3X3))
	combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_MANASHIELD)
	combat:setCondition(condition)
 
function onTargetCreature(creature, target)
    local speed = target:getSpeed(creature)
    local newSpeed = target:getBaseSpeed()
    
    local function speedChange()
		target:changeSpeed(newSpeed)
	end
	local manaDrain = target:getMaxMana()
	target:addMana(-manaDrain/10)
    target:changeSpeed(-speed)
    addEvent(speedChange, 8000)
end
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
 
function onCastSpell(creature, var)
    return combat:execute(creature, var)
end
