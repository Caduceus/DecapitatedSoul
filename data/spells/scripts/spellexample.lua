local areas = {
    {
        {0,0,0},
        {0,0,0},
        {0,0,0},
        {1,3,1},
        {1,0,1}
    },
    {
        {0,0,0},
        {0,0,0},
        {0,0,0},
        {1,1,1},
        {0,2,0}
    },
    {
        {0,0,0},
        {0,0,0},
        {1,1,1},
        {0,0,0},
        {0,2,0}
    },
    {
        {0,0,0},
        {1,1,1},
        {0,0,0},
        {0,0,0},
        {0,2,0}
    },
    {
        {1,1,1},
        {0,0,0},
        {0,0,0},
        {0,0,0},
        {0,2,0}
    }
}
 
local combats = {}
 
-- you only need to define this once if all the combats will use the same function
function onGetFormulaValues(cid, level, maglevel)
    min = -((level / 5) + (maglevel * 10) + 25)
    max = -((level / 5) + (maglevel * 20) + 50)
    return min, max
end
 
for i = 1, #areas do
    combats[i] = Combat()
    combats[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
    combats[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
    combats[i]:setArea(createCombatArea(areas[i]))
    combats[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end
 
function onCastSpell(creature, variant)
 
    -- my script here
 
    for i = 1, #combats do
        combats[i]:execute(creature, variant)
    end
    return true
end

------------------

local area = {
    {
        {0,0,0},
        {0,0,0},
        {0,0,0},
        {1,3,1},
        {1,0,1}
    },
    {
        {0,0,0},
        {0,0,0},
        {0,0,0},
        {1,1,1},
        {0,2,0}
    },
    {
        {0,0,0},
        {0,0,0},
        {1,1,1},
        {0,0,0},
        {0,2,0}
    },
    {
        {0,0,0},
        {1,1,1},
        {0,0,0},
        {0,0,0},
        {0,2,0}
    },
    {
        {1,1,1},
        {0,0,0},
        {0,0,0},
        {0,0,0},
        {0,2,0}
    }
}
 
local combat = {}
 
for i = 1, #area do
    combat[i] = createCombatObject()
    setCombatParam(combat[i], COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
    setCombatParam(combat[i], COMBAT_PARAM_EFFECT, 6)
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