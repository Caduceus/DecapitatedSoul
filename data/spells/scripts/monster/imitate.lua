local combat = Combat()

function onTargetCreature(creature, target)
    local outfit = target:getOutfit(creature)
    doSetCreatureOutfit(creature, outfit, 1000)
    --creature:setOutfit(outfit)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
    return combat:execute(creature, var)
end