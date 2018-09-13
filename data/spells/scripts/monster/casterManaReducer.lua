local combat = Combat()
local condition = Condition()
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POFF)
    combat:setArea(createCombatArea(AREA_CIRCLE3X3))
	combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_MANASHIELD)
	combat:setCondition(condition)
	
local shieldReducer = Condition(CONDITION_ATTRIBUTES)
shieldReducer:setParameter(CONDITION_PARAM_TICKS, 3000)
shieldReducer:setParameter(CONDITION_PARAM_SKILL_SHIELDPERCENT, 70)
 
function onTargetCreature(creature, target)
    local manaDrain = target:getMaxMana()
    
    local function reduceMana()
		target:addMana(-manaDrain/10)
	end
	
	if isInArray({1,2,3}, player:getVocation():getBase():getId()) then
            target:addMana(-manaDrain/10)
			addEvent(reduceMana, 4000) --need ticks?
        elseif isInArray({4,9}, player:getVocation():getBase():getId()) then
			Game.createMonster(config.monsterName[1], config.monsterSpawnPosition)
		end
end
combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")
 
function onCastSpell(creature, var)
    return combat:execute(creature, var)
end
