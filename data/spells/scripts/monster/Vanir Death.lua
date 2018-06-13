local combat = Combat()

local area = createCombatArea({
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

local combat = Combat()
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, 1)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setFormula(COMBAT_FORMULA_SKILL, 20, 30, 20, 0)
combat:setArea(area)

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end

