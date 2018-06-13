local area = createCombatArea({
	{0, 1, 1, 1, 0},
	{1, 1, 1, 1, 1},
	{1, 1, 3, 1, 1},
	{1, 1, 1, 1, 1},
	{0, 1, 1, 1, 0}
})

local combat = Combat()
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, 1)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat:setFormula(COMBAT_FORMULA_SKILL, 9900, 0, 9900, 0)
combat:setArea(area)

function onUseWeapon(player, var)
	return combat:execute(player, var)
end
