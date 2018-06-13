local area = {
    {
        {0,1,0},
        {1,3,1},
        {0,1,0}
    },
    {
		{1,0,1},
        {0,2,0},
        {1,0,1}
    },
    {
		{0,0,1,0,0},
        {0,0,1,0,0},
        {1,0,2,0,1},
        {0,0,1,0,0},
        {0,0,1,0,0}
    },
    {
        {1,0,0,0,1},
        {0,1,0,1,0},
        {0,0,2,0,0},
        {0,1,0,1,0},
        {1,0,0,0,1}
    },
    {
		{0,1,0},
        {1,2,1},
        {0,1,0}
    }
}
 
local combat = {}
 
for i = 1, #area do
    combat[i] = createCombatObject()
    setCombatParam(combat[i], COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
    setCombatParam(combat[i], COMBAT_PARAM_EFFECT, CONST_ME_INSECTS)
    setCombatArea(combat[i], createCombatArea(area[i]))
   
    function onGetFormulaValues(cid, level, maglevel)
        min = -((level / 5) + (maglevel * 10) + 25)
        max = -((level / 5) + (maglevel * 20) + 50)
        return min, max
    end
   
    setCombatCallback(combat[i], CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end
 
local function myLoop(myArray, combatType)
    return doCombat(myArray.cid, combatType, myArray.var)
end
 
function onCastSpell(cid, var)
   
    local myArray = {
        cid = cid,
        var = var
    }
   
    addEvent(myLoop, 250, myArray, combat[2])
    addEvent(myLoop, 500, myArray, combat[3])
    addEvent(myLoop, 750, myArray, combat[4])
    addEvent(myLoop, 1000, myArray, combat[5])
   
    return doCombat(cid, combat[1], var)
end