local combat, types = {}, {COMBAT_FIREDAMAGE, COMBAT_EARTHDAMAGE, COMBAT_ICEDAMAGE, COMBAT_ENERGYDAMAGE, COMBAT_DEATHDAMAGE}
for x = 1, #types do
     combat[x] = Combat()
     combat[x]:setParameter(COMBAT_PARAM_TYPE, types[x])
     combat[x]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
     combat[x]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

    function onGetFormulaValues(cid, level, maglevel)
         min = -1600
         max = -2000
         return min, max
     end     
     combat[x]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end

function onUseWeapon(player, var)
     return combat[math.random(#types)]:execute(player, var)
end