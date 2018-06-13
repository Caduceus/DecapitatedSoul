local combat = {}

    for i = 1, 11 do
        combat[i] = Combat()
        combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
        combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)
        combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.0, -100, -1.6, -100)
    end


    local area = {
        {
			{1, 0, 0, 0, 0},
			{1, 0, 0, 0, 2},
			{1, 0, 0, 0, 0}
        },
        {
            {1, 0, 0, 0},
			{1, 0, 0, 0},
			{1, 0, 0, 0},
			{1, 0, 0, 2},
			{1, 0, 0, 0},
			{1, 0, 0, 0},
			{1, 0, 0, 0}
        },
        {
            {1, 0, 0},
			{1, 0, 0},
			{1, 0, 0},
			{1, 0, 0},
			{1, 0, 2},
			{1, 0, 0},
			{1, 0, 0},
			{1, 0, 0},
			{1, 0, 0}
        },
        {
            {1, 0},
			{1, 0},
			{1, 0},
			{1, 0},
			{1, 0},
			{1, 2},
			{1, 0},
			{1, 0},
			{1, 0},
			{1, 0},
			{1, 0}
        },
        {
           {1},
			{1},
			{1},
			{1},
			{1},
			{3},
			{1},
			{1},
			{1},
			{1},
			{1}
        },
        {
            {0, 1},
			{0, 1},
			{0, 1},
			{0, 1},
			{0, 1},
			{2, 1},
			{0, 1},
			{0, 1},
			{0, 1},
			{0, 1},
			{0, 1}
        },
        {
			{0, 0, 1},
			{0, 0, 1},
			{0, 0, 1},
			{2, 0, 1},
			{0, 0, 1},
			{0, 0, 1},
			{0, 0, 1}
        }, 
        {
			{0, 0, 0, 1},
			{0, 0, 0, 1},
			{2, 0, 0, 1},
			{0, 0, 0, 1},
			{0, 0, 0, 1}
        },
        {
			{0, 0, 0, 0, 1},
			{2, 0, 0, 0, 1},
			{0, 0, 0, 0, 1}
        }
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
     local time_ = {1, 200, 450, 600, 850, 1000, 1250, 1400, 1650, 1800, 2050}
     for t, _ in ipairs(time_) do
         addEvent(executeCombat, time_[t], p, t)
     end
     return true
end
