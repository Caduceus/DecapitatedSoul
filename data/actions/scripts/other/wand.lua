-- everything outside onCastSpell has to be loaded into memory 1st
    local outfit = {47, 89, 91, 120, 232, 246, 305, 311, 320}
    local condition = {}
    local combat = {}
    local ticks = 5 * 60 * 1000

    -- so lets create a table of conditions of outfits and a table of combat objects
    -- which will apply those outfits
    for i = 1, #outfit do
        condition[i] = Condition(CONDITION_OUTFIT)
        combat[i] =  Combat()
      
        condition[i]:setTicks(ticks)
        condition[i]:setOutfit({lookType = outfit[i]})
      
        combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
        combat[i]:setCondition(condition[i])
      
    end

    -- since the above is loaded 1st, we'll use casting of the spell to generate the random outfits
    function onUse(player, item, fromPosition, target, toPosition, isHotkey)
		 player:combat[math.random(1, #combat)]:execute(creature, variant)
		end
	--local v = outfit[math.random(#outfit)]
        --return combat[math.random(1, #combat)]:execute(creature, variant)