-- SpellCreator generated.

-- =============== COMBAT VARS ===============
-- Areas/Combat for 100ms
local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat1, COMBAT_PARAM_BLOCKSHIELD, true)
setCombatArea(combat1,createCombatArea({{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0}}))
function onGetFormulaValues(cid, level, maglevel)
	min = -(level * 50) / 10
	max = -(level * 100) /10
	
	return min, max
end

setCombatCallback(combat1, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

-- Areas/Combat for 600ms
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_EFFECT, CONST_ME_LOSEENERGY)
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat2, COMBAT_PARAM_BLOCKSHIELD, true)
setCombatArea(combat2,createCombatArea({{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0}}))
function onGetFormulaValues(cid, level, maglevel)
	min = -(level * 40) / 10
	max = -(level * 90) /10
	
	return min, max
end

setCombatCallback(combat2, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")



-- Areas/Combat for 900ms
local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat3, COMBAT_PARAM_BLOCKSHIELD, true)
setCombatArea(combat3,createCombatArea({{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0}}))
function onGetFormulaValues(cid, level, maglevel)
	min = -(level * 30) / 10
	max = -(level * 80) /10
	
	return min, max
end
setCombatCallback(combat3, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")


-- Areas/Combat for 1200ms
local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat4, COMBAT_PARAM_BLOCKSHIELD, true)
setCombatArea(combat4,createCombatArea({{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0},
{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0},
{1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1},
{0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0}}))
function onGetFormulaValues(cid, level, maglevel)
	min = -(level * 20) / 10
	max = -(level * 70) /10
	
	return min, max
end

setCombatCallback(combat4, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local function onCastSpell1(parameters)
	doCombat(parameters.cid, parameters.combat1, parameters.var)
end

local function onCastSpell2(parameters)
	doCombat(parameters.cid, parameters.combat2, parameters.var)
end

local function onCastSpell3(parameters)
	doCombat(parameters.cid, parameters.combat3, parameters.var)
end

local function onCastSpell4(parameters)
	doCombat(parameters.cid, parameters.combat4, parameters.var)
end

function onCastSpell(cid, var)
local parameters = { cid = cid, var = var, combat1 = combat1, combat2 = combat2, combat3 = combat3, combat4 = combat4 }

	addEvent(onCastSpell1, 100, parameters) 
	addEvent(onCastSpell2, 600, parameters)
	addEvent(onCastSpell3, 1000, parameters)
	addEvent(onCastSpell4, 1200, parameters)
end 


