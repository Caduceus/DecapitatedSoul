local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE)
combat:setFormula(COMBAT_FORMULA_DAMAGE, 0, -100, 0, -200)
combat:setArea(createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5))
 
local effect = {
    [DIRECTION_NORTH] = CONST_ME_FIREAREA,
    [DIRECTION_EAST] = CONST_ME_ENERGYHIT,
    [DIRECTION_SOUTH] = CONST_ME_MORTAREA,
    [DIRECTION_WEST] = CONST_ME_POISONAREA
}
 
function onCastSpell(creature, variant)
    creature:getPosition():sendMagicEffect(effect[creature:getDirection()])
    return combat:execute(creature, variant)
end