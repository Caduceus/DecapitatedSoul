local DamageTypes = {
    [1] = {DamageType = COMBAT_HOLYDAMAGE, DamageEffect = CONST_ANI_HOLY},
    [2] = {DamageType = COMBAT_FIREDAMAGE, DamageEffect = CONST_ANI_FIRE},
    [3] = {DamageType = COMBAT_DEATHDAMAGE, DamageEffect = CONST_ANI_DEATH},
    [4] = {DamageType = COMBAT_POISONDAMAGE, DamageEffect = CONST_ANI_POISON},
    [5] = {DamageType = COMBAT_ENERGYDAMAGE, DamageEffect = CONST_ANI_ENERGY},
    [6] = {DamageType = COMBAT_EARTHDAMAGE, DamageEffect = CONST_ANI_EARTH},
    [7] = {DamageType = COMBAT_ICEDAMAGE, DamageEffect = CONST_ANI_ICE}
}
 
function onGetFormulaValues(player, level, maglevel)
		min = -((level / 2) + (maglevel * 10.2) + 200) 
        max = -((level / 1.2) + (maglevel * 15.0) + 300) 
	return min, max
end
 
local combat = {}
for k, dam_Table in pairs(DamageTypes) do
    combat[k] = Combat()
    combat[k]:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
    combat[k]:setParameter(COMBAT_PARAM_BLOCKSHIELD, 1)
    combat[k]:setParameter(COMBAT_PARAM_TYPE, dam_Table.DamageType)
    combat[k]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, dam_Table.DamageEffect)
   
    -- _G Is used to manually define 'onGetFormulaValues' in this loop in doesnt seem to be able to find the function.
    _G['onGetFormulaValues' .. k] = onGetFormulaValues
    combat[k]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues" .. k)
end
 
function onUseWeapon(player, var)
    local value = player:getStorageValue(10009)
    local combatUse = combat[value]
    if not combatUse then
        return true
    end
    return combatUse:execute(player, var)
end