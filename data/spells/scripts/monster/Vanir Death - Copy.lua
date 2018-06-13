local area1 = createCombatArea({
{1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
{1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 3, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1},
{1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
})

local area2 = createCombatArea({
{1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
{1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 3, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1},
{1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
})

local area3 = createCombatArea({
{1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
{1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 1, 1, 3, 1, 1, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1},
{1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
})

local combat = Combat1()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -20, -30, -20, 0)

local combat = Combat2()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -20, -30, -20, 0)

local combat = Combat3()
setCombatParam(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
setCombatParam(COMBAT_PARAM_CREATEITEM, 1494)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -20, -30, -20, 0)

local area1 = createCombatArea(area1)
setCombatArea(combat1, area1)

local area2 = createCombatArea(area2)
setCombatArea(combat2, area2)

local area3 = createCombatArea(area3)
setCombatArea(combat3, area3)


function onCastSpell1(creature, var)
	return combat:execute(parameters.cid, parameters.combat1, parameters.var)
end

function onCastSpell2(parameters)
	return combat:execute(parameters.cid, parameters.combat2, parameters.var)
end

function onCastSpell3(parameters)
	return combat:execute(parameters.cid, parameters.combat3, parameters.var)
end

function onCastSpell(creature, var) 
	local parameters = { cid = cid, var = var, combat1 = combat1, combat2 = combat2, combat3 = combat3 }

	addEvent(onCastSpell1, 500, parameters) 
	addEvent(onCastSpell2, 1000, parameters)
	addEvent(onCastSpell3, 1500, parameters)
end 