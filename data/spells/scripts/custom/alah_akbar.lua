local combat_arr = {
    [1] = AREA_CROSS1X1,
    [2] = AREA_CIRCLE2X2,
    [3] = AREA_CIRCLE3X3

}

local times = {1, 500, 1000}

local dmin, dmax = 10, 10
local combat = {} -- keep empty
local monsters = true -- true or false
local suicide = true -- true or false

for i = 1, #combat_arr do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
    _G['onGetFormulaValues'..i] = function () return -math.random(dmin, dmax) end
    combat[i]:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues"..i)
    combat[i]:setArea( createCombatArea(combat_arr[i]) )
end

function newCombat(cid, var, x)
    local player = Player(cid)
    if player then
        if not player and not monsters then
            dmin, dmax = 0, 0
        end
        var.pos = getThingPos(cid)
        combat[x]:execute(player, var)
    end
end

function cast(cid, var)
    newCombat(cid, var, 1)
    for n = 2, #combat do
        addEvent(newCombat, times[n], cid, var, n)
    end
    return true
end

function onCastSpell(creature, variant)
    local cid = creature:getId()
    if suicide then
       local player = Player(cid)
            if player then
                player:addHealth(-player:getMaxHealth())
        end
    end
    return cast(cid, variant)
end
