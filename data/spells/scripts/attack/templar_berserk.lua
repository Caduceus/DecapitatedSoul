 local combat = {}

    for i = 1, 1 do
        combat[i] = Combat()
        combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
        combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA) 
		combat[i]:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)
		combat[i]:setParameter(COMBAT_PARAM_PVPDAMAGE, 250)
        combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.8, -1.8, -1.8, 0)
    end
	
	for i = 2, 2 do
        combat[i] = Combat()
        combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
        combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
        combat[i]:setParameter(COMBAT_PARAM_PVPDAMAGE, 250)
        combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.5, -1.5, -1.5, 0)
    end
	
    local area = {
        {
            {0, 0, 0, 0, 0, 0, 0},
			{0, 0, 1, 1, 1, 0, 0},
			{0, 1, 0, 1, 0, 1, 0},
			{0, 1, 1, 2, 1, 1, 0},
			{0, 1, 0, 1, 0, 1, 0},
			{0, 0, 1, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0, 0, 0, 0},
			{0, 0, 1, 1, 1, 0, 0},
			{0, 1, 0, 1, 0, 1, 0},
			{0, 1, 1, 2, 1, 1, 0},
			{0, 1, 0, 1, 0, 1, 0},
			{0, 0, 1, 1, 1, 0, 0},
			{0, 0, 0, 0, 0, 0, 0}
        },
	}
    for x, _ in ipairs(area) do
        combat[x]:setArea(createCombatArea(area[x]))
    end

    function executeCombat(p, i)
        if not p.creature then
            return false
        end
        if not p.creature:isCreature() then
             return false
        end
        p.combat[i]:execute(p.creature, p.var)
    end

    function onCastSpell(creature, var)
     local p = {creature = creature, var = var, combat = combat}
         local time_ = {1, 300}
         for t, _ in ipairs(time_) do
             addEvent(executeCombat, time_[t], p, t)
         end
         return true
	end
	